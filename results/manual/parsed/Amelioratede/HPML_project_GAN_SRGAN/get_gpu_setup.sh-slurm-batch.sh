#!/bin/bash
#SBATCH --job-name=setup
#SBATCH --output=setup.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:rtx8000:4
#SBATCH --mem=16GB
#SBATCH --time=14:00:00

nvidia-smi -L
nvidia-smi -l 60
