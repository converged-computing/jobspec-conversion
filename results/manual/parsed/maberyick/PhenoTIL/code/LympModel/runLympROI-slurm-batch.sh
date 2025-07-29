#!/bin/bash
#SBATCH --job-name=LympIdentROI
#SBATCH --output=outcome/LIR_%A_%a.out
#SBATCH --error=outcome/LIR_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=90G
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=2-163

module load matlab/R2016b
matlab -nodisplay -r "fullLympIdent_ROI("$SLURM_ARRAY_TASK_ID");exit"
