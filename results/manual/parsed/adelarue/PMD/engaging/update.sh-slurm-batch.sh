#!/bin/bash
#SBATCH --job-name=pkg
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4GB
#SBATCH --time=00:06:00
#SBATCH --partition=sched_mit_sloan_batch
#SBATCH --array=0-0

srun julia pkg_updates.jl $SLURM_ARRAY_TASK_ID
