#!/bin/bash
#SBATCH --job-name=unshuffle
#SBATCH --output=logs/unshuffle-%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8GB
#SBATCH --time=02:00:00

python unshuffle.py $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_MAX
