#!/bin/bash
#FLUX: --job-name=pusheena-arm-7607
#FLUX: --queue=a40        # Use GPU partition "a100"
#FLUX: --priority=16

export EPOCHS='50'
export MODEL='resnet50'
export BATCH_SIZE='256'

export EPOCHS=50
export MODEL="resnet50"
export BATCH_SIZE=256
srun --jobid $SLURM_JOBID bash -c 'python -m deep-learning-base.supervised_training \
--dataset imagenet \
--transform_dataset imagenet \
--save_every 0 \
--model $MODEL \
--batch_size $BATCH_SIZE \
--wandb_name imagenet-training-scratch \
--max_epochs $EPOCHS \
--optimizer sgd \
--lr 0.01 \
--step_lr 5 \
--drop_rate 0.1'
srun --jobid $SLURM_JOBID bash -c 'python -m deep-learning-base.supervised_training \
--dataset imagenet \
--transform_dataset imagenet \
--save_every 0 \
--model $MODEL \
--batch_size $BATCH_SIZE \
--wandb_name imagenet-training-scratch \
--max_epochs $EPOCHS \
--optimizer sgd \
--lr 0.01 \
--step_lr 5 \
--drop_rate 0.2'
srun --jobid $SLURM_JOBID bash -c 'python -m deep-learning-base.supervised_training \
--dataset imagenet \
--transform_dataset imagenet \
--save_every 0 \
--model $MODEL \
--batch_size $BATCH_SIZE \
--wandb_name imagenet-training-scratch \
--max_epochs $EPOCHS \
--optimizer sgd \
--lr 0.01 \
--step_lr 5 \
--drop_rate 0.3'
srun --jobid $SLURM_JOBID bash -c 'python -m deep-learning-base.supervised_training \
--dataset imagenet \
--transform_dataset imagenet \
--save_every 0 \
--model $MODEL \
--batch_size $BATCH_SIZE \
--wandb_name imagenet-training-scratch \
--max_epochs $EPOCHS \
--optimizer sgd \
--lr 0.01 \
--step_lr 5 \
--drop_rate 0.4'
