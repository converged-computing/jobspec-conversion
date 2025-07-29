#!/bin/bash
#SBATCH --job-name=isccp_solar
#SBATCH --output=logs/solar-%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8GB
#SBATCH --time=04:00:00

/home/cphillips/.conda/envs/dev/bin/python solar.py --missing $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_MAX
