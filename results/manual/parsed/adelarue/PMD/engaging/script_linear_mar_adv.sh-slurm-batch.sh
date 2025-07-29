#!/bin/bash
#SBATCH --job-name=lin_nmar_out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4GB
#SBATCH --time=4-00:00:00
#SBATCH --partition=sched_mit_sloan_batch
#SBATCH --array=54
#SBATCH --exclude=node1111,node1333

srun julia fakey.jl $SLURM_ARRAY_TASK_ID 1 1 "linear"
