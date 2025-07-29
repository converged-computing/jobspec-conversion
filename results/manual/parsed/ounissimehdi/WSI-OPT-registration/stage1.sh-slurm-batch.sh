#!/bin/bash
#SBATCH --job-name=S1:reg-para
#SBATCH --output=./bash-log/%A_%a.txt
#SBATCH --error=./bash-log/%A_%a.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=12-12:00:00
#SBATCH --chdir=.
#SBATCH --array=1-219

python para_reg_v3.py -img_id ${SLURM_ARRAY_TASK_ID}
