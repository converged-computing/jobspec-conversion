#!/bin/bash
#SBATCH --job-name=amorelli_job
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=128000
#SBATCH --partition=longrun

module load cuda/11.4
module load cudnn/8.2
module load openmpi
module list
nvidia-smi
nvcc --version
srun python training.py
