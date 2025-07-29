#!/bin/bash
#SBATCH --output=./reports/slurm-%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3-08:00:00
#SBATCH --constraint=intel,ntasks-per-node=1
#SBATCH --array=1-1000

cd ~/measles/code/
module load R
R CMD BATCH -$SLURM_ARRAY_TASK_ID likelihood-profile-mifs.R
