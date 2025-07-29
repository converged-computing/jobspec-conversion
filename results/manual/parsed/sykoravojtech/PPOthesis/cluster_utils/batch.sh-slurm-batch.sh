#!/bin/bash
#SBATCH --job-name=table
#SBATCH --output=slurm/table-gustySides-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --partition=amd

cd /mnt/personal/sykorvo1/PPOthesis/ppo
python run_model.py --load_model BEST/gustySides/ep780_4to5
