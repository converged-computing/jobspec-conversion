#!/bin/bash
#SBATCH --job-name=array_job
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=8G
#SBATCH --partition=campus-new
#SBATCH --array=1-500

echo "$SLURM_ARRAY_TASK_ID"
ml R
R CMD BATCH simula.r simula.rout
