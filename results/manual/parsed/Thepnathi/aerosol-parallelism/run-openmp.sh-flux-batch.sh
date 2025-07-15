#!/bin/bash
#FLUX: --job-name=anxious-leader-8615
#FLUX: --priority=16

module load compilers/intel/2019u5 
module load mpi/intel-mpi/2019u5/bin
echo "Node list                    : $SLURM_JOB_NODELIST"
echo "Number of nodes allocated    : $SLURM_JOB_NUM_NODES or $SLURM_NNODES"
echo "Number of threads or processes          : $SLURM_NTASKS"
echo "Number of processes per node : $SLURM_TASKS_PER_NODE"
echo "Requested tasks per node     : $SLURM_NTASKS_PER_NODE"
echo "Requested CPUs per task      : $SLURM_CPUS_PER_TASK"
echo "Scheduling priority          : $SLURM_PRIO_PROCESS"
if [ "$SLURM_NNODES" -gt "1" ]; then 
    echo more than 1 node not allowed
    exit
fi
SRC=openmp-aerosol.c
EXE=${SRC%%.c}.exe
rm -f ${EXE}
echo compiling $SRC to $EXE
icc -qopenmp -O0 $SRC  -o $EXE 
if test -x $EXE; then
      # set number of threads
      export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK:-1} # if '-c' not used then default to 1
      echo Using ${OMP_NUM_THREADS} OpenMP threads
      # run multiple times
      ./${EXE};echo
else
     echo $SRC did not built to $EXE
fi
