#!/bin/bash
#SBATCH --job-name=array_job
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --partition=panda
#SBATCH --array=1-500

echo "$SLURM_ARRAY_TASK_ID"
source ~/.bashrc
spack load -r @3.5.1
R CMD BATCH simula.r simula.rout
