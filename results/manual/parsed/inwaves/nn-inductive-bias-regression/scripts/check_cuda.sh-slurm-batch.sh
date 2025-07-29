#!/bin/bash
#SBATCH --job-name=check-cuda
#SBATCH --account=[REDACTED]
#SBATCH --output=slurm-out/%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

python3 check_cuda.py
