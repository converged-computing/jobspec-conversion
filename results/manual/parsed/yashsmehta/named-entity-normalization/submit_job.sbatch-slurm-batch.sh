#!/bin/bash
#SBATCH --job-name=np
#SBATCH --output=logs/ym_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=7G
#SBATCH --time=00:01:00

srun -u python scraper.py
