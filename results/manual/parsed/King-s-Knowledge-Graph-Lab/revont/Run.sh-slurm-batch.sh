#!/bin/bash
#SBATCH --job-name=gpu
#SBATCH --output=/scratch/users/%u/log.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --constraint=a100

python main-copy.py
