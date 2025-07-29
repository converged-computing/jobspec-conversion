#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=output.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=lva
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=12

mpirun --mca fs_ufs_lock_algorithm 1 -np 12 ./bin/saveBufferNonCollective
