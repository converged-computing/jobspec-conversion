#!/bin/bash
#SBATCH --job-name=matching
#SBATCH --output=out_files/exec_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=30GB
#SBATCH --time=08:00:00
#SBATCH --array=0-14

python appli_matching.py ${SLURM_ARRAY_TASK_ID}
