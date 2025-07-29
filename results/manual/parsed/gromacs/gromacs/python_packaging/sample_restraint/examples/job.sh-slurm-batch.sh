#!/bin/bash
#SBATCH --account=kas_dev
#SBATCH --nodes=12
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=01:00:00
#SBATCH --partition=parallel
#SBATCH --constraint=ntasks-per-node=1

module load gcc
module load openmpi
srun python -m mpi4py restrained-ensemble.py 12
