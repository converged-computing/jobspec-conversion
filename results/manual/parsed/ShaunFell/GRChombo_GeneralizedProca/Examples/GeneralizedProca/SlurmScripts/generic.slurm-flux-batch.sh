#!/bin/bash
#FLUX: --job-name=GRChombo_Proca
#FLUX: --priority=16

export environment='testing"  ## values should be either 'prod' for production or 'testing' for testing'
export LD_LIBRARY_PATH='${LD_LIBRARY_PATH}:${PETSC_DIR}/lib'
export MPIRUN_OPTIONS='--bind-to core --map-by socket:PE=${OMP_NUM_THREADS}'
export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'
export NUM_CORES='${SLURM_NTASKS}*${OMP_NUM_THREADS}'
export OMPI_MCA_btl_openib_if_exclude='mlx5_2'
export EXECUTABLE='./Main_GeneralizedProca3d.Linux.64.mpicxx.gfortran.MPI.OPENMPCC.ex params/${PARAMFILE}'

export environment="testing"  ## values should be either 'prod' for production or 'testing' for testing
cd "/home/hd/hd_hd/hd_pb293/Documents/Github/ProblemsWithProca/proca-on-kerr/Examples/GeneralizedProca"
module load compiler/gnu/10.2 mpi/openmpi lib/hdf5/1.12.2-gnu-10.2-openmpi-4.1 numlib/gsl/2.6-gnu-10.2 numlib/petsc/3.17.2-gnu-10.2-openmpi-4.1
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${PETSC_DIR}/lib
export MPIRUN_OPTIONS="--bind-to core --map-by socket:PE=${OMP_NUM_THREADS}"
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export NUM_CORES=${SLURM_NTASKS}*${OMP_NUM_THREADS}
export OMPI_MCA_btl_openib_if_exclude=mlx5_2
OUTPATH="/pfs/work7/workspace/scratch/hd_pb293-WS_GRChombo/${environment}/${SLURM_JOB_NAME}_${SLURM_JOB_ID}"
mkdir $OUTPATH
PARAMFILE=$1
sed -i 's|.*output_path.*|output_path = '"\"$OUTPATH\""'|' params/$PARAMFILE
VISITSESSIONFILE="/home/hd/hd_hd/hd_pb293/JobScripts/GRChombo/ProcaSuperradiance/visit.session"
VISITSESSIONGUIFILE="/home/hd/hd_hd/hd_pb293/JobScripts/GRChombo/ProcaSuperradiance/visit.session.gui"
cp $VISITSESSIONFILE $OUTPATH
cp $VISITSESSIONGUIFILE $OUTPATH
sed -i "s/XXXXXXXX/${SLURM_JOB_ID}/g" ${OUTPATH}/visit.session
sed -i "s/XXXXXXXX/${SLURM_JOB_ID}/g" ${OUTPATH}/visit.session.gui
cp params/$PARAMFILE $OUTPATH/params.txt
export EXECUTABLE="./Main_GeneralizedProca3d.Linux.64.mpicxx.gfortran.MPI.OPENMPCC.ex params/${PARAMFILE}"
echo ""
echo ""
echo ""
echo "[ job ID = ${SLURM_JOB_ID} ]"
echo "[ running on $SLURM_PARTITION on nodes: $SLURM_NODELIST ]"
echo "[ with ${NUM_CORES} cores for ${SLURM_NTASKS} MPI tasks and ${OMP_NUM_THREADS} OMP threads each ]"
echo "[ now: $(date) ]"
echo ""
echo ""
echo "Parameter file:"
for line in "$(cat params/${PARAMFILE})"
do
	echo "$line";
done
echo ""
echo ""
echo ""
startexe="mpirun -n ${SLURM_NTASKS} ${MPIRUN_OPTIONS} ${EXECUTABLE}"
echo $startexe
exec $startexe
echo "simulation finished"
exit 0
