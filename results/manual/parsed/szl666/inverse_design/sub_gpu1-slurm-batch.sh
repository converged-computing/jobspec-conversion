#!/bin/bash
#SBATCH --job-name=zhilong
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu4

module load cuda/11.3
python stable_pre.py
