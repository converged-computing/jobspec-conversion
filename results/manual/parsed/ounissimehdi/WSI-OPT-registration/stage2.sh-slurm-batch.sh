#!/bin/bash
#SBATCH --job-name=S2:reg-LARGE
#SBATCH --output=./bash-log/REG-%A_%a.txt
#SBATCH --error=./bash-log/REG-%A_%a.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --time=12-12:00:00
#SBATCH --chdir=.
#SBATCH --array=0-218

python reg_large.py -img_id ${SLURM_ARRAY_TASK_ID}
