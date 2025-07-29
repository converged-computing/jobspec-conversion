#!/bin/bash
#SBATCH --job-name=isccp_timing
#SBATCH --output=logs/timing-%a.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=6GB
#SBATCH --time=04:00:00

/home/cphillips/.conda/envs/dev/bin/python make_timing.py $SLURM_ARRAY_TASK_ID $SLURM_ARRAY_TASK_MAX
