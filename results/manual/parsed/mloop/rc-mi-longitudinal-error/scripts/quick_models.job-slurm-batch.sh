#!/bin/bash
#SBATCH --job-name=quick-models
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1g
#SBATCH --time=00:10:00
#SBATCH --partition=general
#SBATCH --array=1-5000

set -o errexit
module load gcc/9.3.0
module load R/4.2.3
Rscript 02_naive.R $SLURM_ARRAY_TASK_ID
Rscript 03_complete_case.R $SLURM_ARRAY_TASK_ID
Rscript 07_true_model.R $SLURM_ARRAY_TASK_ID
