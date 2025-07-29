#!/bin/bash
#SBATCH --job-name=DARTS_grid_eval
#SBATCH --output=./logs_eval/%A_%a.o
#SBATCH --error=./logs_eval/%A_%a.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=1080Ti
#SBATCH --chdir=.
#SBATCH --array=1-3

source activate pytorch-0.3.1-cu8-py36
python src/evaluation/train.py --cutout --auxiliary --job_id $SLURM_ARRAY_JOB_ID --task_id 1 --seed 1 --space $1 --dataset $2 --search_dp $3 --search_wd $4 --search_task_id $SLURM_ARRAY_TASK_ID
