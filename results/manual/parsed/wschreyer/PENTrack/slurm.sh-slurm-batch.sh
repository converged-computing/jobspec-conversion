#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --array=1-250

ID=$SLURM_ARRAY_TASK_ID  # Slurm array task index
JOB=$SLURM_ARRAY_JOB_ID  # Slurm job ID
./PENTrack $JOB$ID ./in/config.in ./out/
