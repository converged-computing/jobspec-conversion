#!/bin/bash
#SBATCH --job-name=RandomNAS
#SBATCH --output=./experiments/cluster_logs/%A_%a.o
#SBATCH --error=./experiments/cluster_logs/%A_%a.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --partition=meta_gpu-ti
#SBATCH --chdir=.
#SBATCH --array=1-3

source activate pytorch-0.3.1-cu8-py36
python src/search/randomNAS/random_weight_share.py --job_id $SLURM_ARRAY_JOB_ID --task_id $SLURM_ARRAY_TASK_ID --seed $SLURM_ARRAY_TASK_ID --epochs 50 --save experiments/search_logs_RandomNAS --space $1 --dataset $2 --drop_path_prob $3 --weight_decay $4
