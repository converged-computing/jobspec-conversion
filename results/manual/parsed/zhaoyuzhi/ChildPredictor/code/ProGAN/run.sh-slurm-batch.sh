#!/bin/bash
#SBATCH --job-name=mixture1
#SBATCH --output=./logs/mixtureFace_GAN_MSGAN_ACGAN.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:8

srun --mpi=pmi2 python -u train.py
