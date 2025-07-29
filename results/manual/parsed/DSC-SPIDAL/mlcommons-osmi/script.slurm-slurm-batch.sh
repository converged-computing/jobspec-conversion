#!/bin/bash
#SBATCH --job-name=poisson
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=7
#SBATCH --gres=bii-gpu:8
#SBATCH --mem-per-cpu=256G
#SBATCH --time=00:10:00

module purge
module load anaconda3
conda activate myenv
nvidia-smi
