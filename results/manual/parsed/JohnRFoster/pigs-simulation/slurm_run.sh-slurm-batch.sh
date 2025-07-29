#!/bin/bash
#SBATCH --job-name=array_5
#SBATCH --output=outfiles/array_5_%J.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --array=1-5

module load R
Rscript R/workflow.R $SLURM_ARRAY_TASK_ID 
