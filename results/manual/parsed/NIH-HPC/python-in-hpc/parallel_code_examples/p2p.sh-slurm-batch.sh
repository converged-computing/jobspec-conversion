#!/bin/bash
#SBATCH --job-name=p2p_test
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --constraint=x2680

module load mpi4py
module load python/3.6
srun --mpi=pmix ./p2p.py
