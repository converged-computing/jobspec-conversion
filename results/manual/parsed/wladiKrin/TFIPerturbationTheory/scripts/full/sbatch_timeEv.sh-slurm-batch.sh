#!/bin/bash
#SBATCH --job-name=EDTimeEvol
#SBATCH --output=log_EDTimeEvol%a
#SBATCH --error=log_EDTimeEvol%a
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-7

julia -t 48 HfullBound_timeEvol.jl ${SLURM_ARRAY_TASK_ID}
