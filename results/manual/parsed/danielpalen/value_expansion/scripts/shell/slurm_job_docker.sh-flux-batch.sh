#!/bin/bash
#FLUX: --job-name=docker_iclr23
#FLUX: --queue=rtx2
#FLUX: -t=259200
#FLUX: --urgency=16

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
