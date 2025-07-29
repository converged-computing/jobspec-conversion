#!/bin/bash
#SBATCH --job-name=test3
#SBATCH --output=test3.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1

module load python/3.10.pytorch
mpirun python3 /csehome/m23mac008/cvproject/draft.py >> test3.out
