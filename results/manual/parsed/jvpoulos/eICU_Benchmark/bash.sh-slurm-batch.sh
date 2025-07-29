#!/bin/bash
#SBATCH --job-name=bash
#SBATCH --error=bash.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=25G

module load CUDA/10.1
nvcc -V
nvidia-smi
source /hpc/home/jvp5/storage/venv/bin/activate
python bash.py
