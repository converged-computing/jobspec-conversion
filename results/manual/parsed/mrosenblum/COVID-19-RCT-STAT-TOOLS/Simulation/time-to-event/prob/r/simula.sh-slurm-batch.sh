#!/bin/bash
#SBATCH --job-name=array_job
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --partition=curie-cpu
#SBATCH --array=1-500

echo "$SLURM_ARRAY_TASK_ID"
source ~/.bashrc
spack load /mjrrusu
R CMD BATCH simula.r simula.rout
