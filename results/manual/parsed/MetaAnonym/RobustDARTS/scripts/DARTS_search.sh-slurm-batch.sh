#!/bin/bash
#SBATCH --job-name=DARTS_grid
#SBATCH --output=./logs_search/%A_%a.o
#SBATCH --error=./logs_search/%A_%a.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=1080Ti
#SBATCH --chdir=.
#SBATCH --array=1

source activate pytorch-0.3.1-cu8-py36
python src/search/train_search.py --unrolled --job_id $SLURM_ARRAY_JOB_ID --task_id $SLURM_ARRAY_TASK_ID --seed $SLURM_ARRAY_TASK_ID --cutout --report_freq_hessian 2 --space $1 --dataset $2 --drop_path_prob $3 --weight_decay $4
