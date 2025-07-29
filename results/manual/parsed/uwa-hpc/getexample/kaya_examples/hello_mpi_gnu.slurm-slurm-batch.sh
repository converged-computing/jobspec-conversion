#!/bin/bash
#FLUX: --job-name=GE-fortranMPI_gnu
#FLUX: -N=3
#FLUX: -n=30
#FLUX: --queue=test
#FLUX: -t=60
#FLUX: --urgency=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module load gcc/8.3.1 openmpi/4.0.5
module list
EXECUTABLE=hello_mpi_gnu
SCRATCH=$MYSCRATCH/run_fortranMPI_gnu/$SLURM_JOBID
RESULTS=$MYGROUP/mpifortran_gnu_results/$SLURM_JOBID
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
if [ ! -d $SCRATCH ]; then 
    mkdir -p $SCRATCH 
fi 
echo SCRATCH is $SCRATCH
if [ ! -d $RESULTS ]; then 
    mkdir -p $RESULTS 
fi
echo the results directory is $RESULTS
OUTPUT=fortranMPI_gnu.log
cd ${SLURM_SUBMIT_DIR}
cp $EXECUTABLE $SCRATCH
cd $SCRATCH
echo " "
echo " first with mpirun "
echo " "
echo " " 
echo " okay now with srun "
echo "  "
srun --mpi=pmix_v3 ./${EXECUTABLE} >> ${OUTPUT}
mv  $OUTPUT ${RESULTS}
cd $HOME
rm -r $SCRATCH
echo fortranMPI_gnu job finished at  `date`
