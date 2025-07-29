#!/bin/bash
#SBATCH --job-name=ll%A
#SBATCH --output=logs/ll_%A_%a.out
#SBATCH --error=logs/ll_%A_%a.err
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10000
#SBATCH --time=02:00:00

ml purge
ml load R/3.5.1
ml load gcc/8.1.0
model_id=$1
params_id=$2
Rscript src/05_loo/compute_LL.R ${model_id} ${params_id} $SLURM_ARRAY_TASK_ID
