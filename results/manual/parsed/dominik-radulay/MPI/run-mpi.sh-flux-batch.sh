#!/bin/bash
#FLUX: --job-name=phat-leopard-7424
#FLUX: --priority=16

export numMPI='${SLURM_NTASKS:-1} # if '-n' not used then default to 1'

module load compilers/intel/2019u5 
module load mpi/intel-mpi/2019u5/bin
ulimit -s unlimited
echo "Node list                    : $SLURM_JOB_NODELIST"
echo "Number of nodes allocated    : $SLURM_JOB_NUM_NODES or $SLURM_NNODES"
echo "Number of threads or processes          : $SLURM_NTASKS"
echo "Number of processes per node : $SLURM_TASKS_PER_NODE"
echo "Requested tasks per node     : $SLURM_NTASKS_PER_NODE"
echo "Requested CPUs per task      : $SLURM_CPUS_PER_TASK"
echo "Scheduling priority          : $SLURM_PRIO_PROCESS"
SRC=op3.c
EXE=${SRC%%.c}.exe
echo compiling $SRC to $EXE
export numMPI=${SLURM_NTASKS:-1} # if '-n' not used then default to 1
mpiicc $SRC -o $EXE -std=c99 -lgomp -lm && \
      (
      # run 3 times
      #mpirun -np ${numMPI} ./${EXE} files/a1.dat files/b1.dat files/output.dat ;echo
      #mpirun -np ${numMPI} ./${EXE} files/sort.dat files/out.dat ;echo
      mpirun  -np ${numMPI} ./${EXE} ${numMPI}.dat ${numMPI}_o.dat ;echo
      mpirun  -np ${numMPI} ./${EXE} ${numMPI}.dat ${numMPI}_o.dat ;echo
      mpirun  -np ${numMPI} ./${EXE} ${numMPI}.dat ${numMPI}_o.dat ;echo
      #mpirun -np ${numMPI} ./${EXE} files/a1.dat files/b1.dat files/c1.dat ;echo
      #mpirun -np ${numMPI} ./${EXE} files/input.dat files/output.dat ;echo
      #mpirun -np ${numMPI} ./${EXE} files/input_64_512_960.dat files/kernel_5.dat files/output.dat ;echo
      #mpirun -np ${numMPI} ./${EXE} files/input_64_512_960.dat files/kernel_5.dat files/output.dat ;echo
      #mpirun -np ${numMPI} ./${EXE} files/input_64_512_960.dat files/kernel_5.dat files/output.dat ;echo
      #mpirun -np ${numMPI} ./${EXE} files/input_2_5_5.dat files/kernel_5.dat files/output.dat ;echo
      #mpirun -np ${numMPI} ./${EXE} files/input_3_5_5.dat files/kernel_5.dat files/output.dat ;echo
  ) \
      || echo $SRC did not built to $EXE
