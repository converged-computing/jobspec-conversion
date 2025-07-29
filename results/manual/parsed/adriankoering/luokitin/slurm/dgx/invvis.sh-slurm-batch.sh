#!/bin/bash
#SBATCH --job-name=extra_rgb_rn34
#SBATCH --output=logs/slogs/%A_%a.out
#SBATCH --error=logs/slogs/%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --mem=6G
#SBATCH --time=01:00:00
#SBATCH --partition=p2
#SBATCH --qos=low
#SBATCH --array=1-24%2

export WANDB_PROJECT='invvis'
export WANDB_NAME='${SLURM_JOB_NAME}'
export WANDB_JOB_TYPE='devel'
export WANDB_JOB_NAME='${WANDB_NAME}'
export WANDB_TAGS='devel,rgb,extra,resnet34'
export HYDRA_FULL_ERROR='1 '

export WANDB_PROJECT=invvis
export WANDB_NAME=${SLURM_JOB_NAME}
export WANDB_JOB_TYPE=devel
export WANDB_JOB_NAME=${WANDB_NAME}
export WANDB_TAGS="devel,rgb,extra,resnet34"
export HYDRA_FULL_ERROR=1 
srun python train.py experiment=invvis/rgb dataset.data_dir=/home/koering/data/invvis/webds/extra model/encoder=resnet34 # -c job --resolve
