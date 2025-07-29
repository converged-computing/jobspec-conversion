#!/bin/bash
#SBATCH --job-name=generate_text
#SBATCH --account=umutlu
#SBATCH --output=generate-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --gres=gpu:1
#SBATCH --time=04:00:00

srun python inference.py
