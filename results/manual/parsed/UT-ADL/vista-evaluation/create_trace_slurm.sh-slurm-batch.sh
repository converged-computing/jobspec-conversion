#!/bin/bash
#SBATCH --job-name=train
#SBATCH --output=./runs/%j-slurm-run.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem=20G
#SBATCH --time=23:59:00
#SBATCH --exclude=falcon2,falcon3

srun python -u create_trace.py "$@"
