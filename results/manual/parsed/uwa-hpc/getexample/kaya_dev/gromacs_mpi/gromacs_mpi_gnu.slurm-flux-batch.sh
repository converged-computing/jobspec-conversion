#!/bin/bash
#FLUX: --job-name=gromacs_mpi
#FLUX: -N=2
#FLUX: --queue=workq
#FLUX: -t=2400
#FLUX: --priority=16

module swap PrgEnv-cray PrgEnv-gnu
module load gromacs/5.1.1
module list
echo submission dir $SLURM_SUBMIT_DIR
EXECUTABLE=gmx 
SCRATCH=$MYSCRATCH/run_gromacs/$SLURM_JOBID
RESULTS=$MYGROUP/gromacs_results/$SLURM_JOBID
INPUT_DATA_DIR=${SLURM_SUBMIT_DIR}/gromacs_mpi
GROMACS_DATA_DIR=${SLURM_SUBMIT_DIR}
OUTFILE=1AKI_processed.gro
PDB_FILE=1AKI.pdb
if [ ! -d $SCRATCH ]; then 
    mkdir -p $SCRATCH 
fi 
echo SCRATCH is $SCRATCH
if [ ! -d $RESULTS ]; then 
    mkdir -p $RESULTS 
fi
echo the results directory is $RESULTS
OUTPUT=gromacs_mpi.log
cp $GROMACS_DATA_DIR/*.pdb $SCRATCH
cp $INPUT_DATA_DIR/posre.itp $SCRATCH
cp $INPUT_DATA_DIR/1AKI_processed.gro $SCRATCH
cp $INPUT_DATA_DIR/topol.top $SCRATCH
cp $INPUT_DATA_DIR/*.mdp $SCRATCH
echo gmxlib is $GMXLIB
cd $SCRATCH
aprun -n 1 -N 1 $EXECUTABLE pdb2gmx -f ${PDB_FILE} -o $OUTFILE -water spce << EOF
29
0
EOF
aprun -n 1 -N 1 gmx_d editconf -f 1AKI_processed.gro  -o 1AKI_newbox.gro -c -d 1.0 -bt cubic  > ${OUTPUT}
aprun -n 1 -N 1 gmx_d solvate -cp 1AKI_newbox.gro -cs spc216.gro -o 1AKI_solv.gro -p topol.top >> ${OUTPUT}
aprun -n 1 -N 1 gmx_d grompp -f ions.mdp -c 1AKI_solv.gro -p topol.top -o ions.tpr >> ${OUTPUT}
aprun -n 1 -N 1 gmx_d genion -s ions.tpr -o 1AKI_solv_ions.gro -p topol.top  -pname NA -nname CL -nn 8 << EOF 
13
EOF
aprun -n 1 -N 1 gmx_d grompp -f minim.mdp -c 1AKI_solv_ions.gro -p topol.top -o em.tpr >> ${OUTPUT}
aprun -n 48 -N 24 mdrun_mpi_d  -v -deffnm em -g energy.log >> ${OUTPUT}
mv $OUTPUT ${RESULTS}
cd $HOME
echo gromacs_mpi job finished at  `date`
