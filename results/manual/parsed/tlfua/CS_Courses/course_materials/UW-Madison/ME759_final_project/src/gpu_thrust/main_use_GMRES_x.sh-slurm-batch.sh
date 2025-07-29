#!/bin/bash
#SBATCH --job-name=main_use_GMRES
#SBATCH --output=main_use_GMRES.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:10:00

srun main_use_GMRES
