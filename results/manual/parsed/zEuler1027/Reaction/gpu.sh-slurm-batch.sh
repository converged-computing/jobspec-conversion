#!/bin/bash
#SBATCH --job-name=DDPM
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --partition=gpu

module load conda
conda activate oa_reactdiff
python train.py
