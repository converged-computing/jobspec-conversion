#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/negin513/distributed-pytorch-hpc/tests/torchrun_mpi_comm_test3.sh
