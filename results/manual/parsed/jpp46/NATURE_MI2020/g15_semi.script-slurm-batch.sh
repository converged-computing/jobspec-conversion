#!/bin/bash
#SBATCH --job-name=15 semi
#SBATCH --output=job_%j.out
#SBATCH --mail-user=powersj@msoe.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4gb
#SBATCH --partition=teaching

julia worker_semi.jl ${SLURM_ARRAY_TASK_ID} 15
