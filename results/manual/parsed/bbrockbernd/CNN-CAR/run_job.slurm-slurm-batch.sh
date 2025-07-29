#!/bin/bash
#SBATCH --job-name=dist_training
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=128G
#SBATCH --time=05:00:00

module load 2022r1
module load gpu
module load python/3.8.12-bohr45d
module load openmpi
module load py-tensorflow
srun python Model2D.py
