#!/bin/bash
#FLUX: --job-name=delicious-caramel-0951
#FLUX: --urgency=16

module load compilers/intel/2019u5 
echo "Node list                    : $SLURM_JOB_NODELIST"
echo "Number of nodes allocated    : $SLURM_JOB_NUM_NODES or $SLURM_NNODES"
echo "Number of threads or processes          : $SLURM_NTASKS"
echo "Number of processes per node : $SLURM_TASKS_PER_NODE"
echo "Requested tasks per node     : $SLURM_NTASKS_PER_NODE"
echo "Requested CPUs per task      : $SLURM_CPUS_PER_TASK"
echo "Scheduling priority          : $SLURM_PRIO_PROCESS"
SRC=$1
EXE=${SRC%%.c}.exe 
rm -f ${EXE} 
echo compiling $SRC to $EXE 
icc -qopenmp -O0 -std=c99 $SRC  -o $EXE  
echo
echo ------------------------------------
if test -x $EXE; then 
      # set number of threads
      # if '-c' not used then default to 1. SLURM_CPUS_PER_TASK is given by -c
      export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK:-1} 
      echo using ${OMP_NUM_THREADS} OpenMP threads
      echo
      echo 
      echo Multiple execution..
      echo
      echo
      # run multiple times. Because we have exported how many threads we're using, we just execute the file.
      for i in {1..5}; do ./${EXE}; done     
else
     echo $SRC did not built to $EXE
fi
