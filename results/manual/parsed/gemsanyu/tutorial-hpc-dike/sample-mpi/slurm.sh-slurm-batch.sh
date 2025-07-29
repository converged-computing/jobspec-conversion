#!/bin/bash
#SBATCH --job-name=test_mpi
#SBATCH --output=result_mpi.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:01:00
#SBATCH --constraint=ntasks-per-node=20

srun --mpi=pmix hello.mpi
