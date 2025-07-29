#!/bin/bash
#SBATCH --job-name=sweep-job
#SBATCH --account=aaydin
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:2
#SBATCH --time=04:01:00
#SBATCH --exclude=palamut9

CUDA_VISIBLE_DEVICES=0 singularity run --nv deep-learning_latest.sif wandb agent ayberkydn/vis/zolkri6c &
CUDA_VISIBLE_DEVICES=0 singularity run --nv deep-learning_latest.sif wandb agent ayberkydn/vis/zolkri6c &
CUDA_VISIBLE_DEVICES=1 singularity run --nv deep-learning_latest.sif wandb agent ayberkydn/vis/zolkri6c &
CUDA_VISIBLE_DEVICES=1 singularity run --nv deep-learning_latest.sif wandb agent ayberkydn/vis/zolkri6c &
