#!/bin/bash
#SBATCH --job-name=LympIdent
#SBATCH --output=outcome/LIdent_%A_%a.out
#SBATCH --error=outcome/LIdent_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64G
#SBATCH --time=4-04:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-2

module load matlab/R2016b
matlab -nodisplay -r "fullLympIdent_TMA("$SLURM_ARRAY_TASK_ID");exit"
