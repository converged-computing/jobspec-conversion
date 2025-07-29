#!/bin/bash
#SBATCH --job-name=docker_iclr23
#SBATCH --output=[TODO]
#SBATCH --error=[TODO]
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=6000
#SBATCH --time=3-00:00:00
#SBATCH --array=1-9

WANDB_API_KEY="[TODO YOUR KEY]"  # or 'wandb login' and 'wandb docker' commands
WANDB_ENTITY="[TODO YOUR ENTITY]"
source ias-rootless-dockerd-start
docker run --rm --gpus all \
    -e WANDB_API_KEY=$WANDB_API_KEY \
    value_expansion:latest \
    python run_experiment.py \
          -env $ENV \
          -algo $ALGO \
          -model_type $MODEL \
          -H $HORIZON \
          -gpu $GPU \
          -seed $SLURM_ARRAY_TASK_ID \
          -wandb_mode "online"\
          -wandb_entity $WANDB_ENTITY \
          -wandb_project "iclr23_value_expansion"
