#!/bin/bash
#SBATCH --job-name=select
#SBATCH --output=./baby_select.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:0
#SBATCH --partition=Pixel

srun --mpi=pmi2 python -u main.py
