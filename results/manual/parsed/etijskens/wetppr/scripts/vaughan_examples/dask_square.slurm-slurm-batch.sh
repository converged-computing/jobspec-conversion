#!/bin/bash
#SBATCH --job-name=dask_square
#SBATCH --output=%x.%j.stdout
#SBATCH --error=%x.%j.stderr
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00

module --force purge
module load calcua/2020a
module load Python
module list
srun python dask_square.py
