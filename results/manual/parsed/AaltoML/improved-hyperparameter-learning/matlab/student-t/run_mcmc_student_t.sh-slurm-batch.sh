#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=2-00:00:00
#SBATCH --constraint=csl|skl
#SBATCH --array=1-3

mkdir -p result
matlab -r "mcmc_student_t($SLURM_ARRAY_TASK_ID)"
