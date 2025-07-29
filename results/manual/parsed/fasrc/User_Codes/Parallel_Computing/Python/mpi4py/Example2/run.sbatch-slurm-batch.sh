#!/bin/bash
#SBATCH --job-name=optimize_mpi
#SBATCH --output=optimize_mpi.out
#SBATCH --error=optimize_mpi.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000
#SBATCH --time=00:30:00
#SBATCH --partition=test

module load python/3.10.12-fasrc01
source activate python3_env1
srun -n 8 --mpi=pmi2 python optimize_mpi.py
