#!/bin/bash
#FLUX: --job-name=placid-peanut-butter-1071
#FLUX: --priority=16

srun --jobid $SLURM_JOBID bash -c 'python -m deep-learning-base.supervised_training \
--dataset imagenet \
--transform_dataset imagenet \
--save_every 0 \
--model resnet50 \
--batch_size 256 \
--wandb_name imagenet-training-scratch \
--max_epochs 50 \
--optimizer sgd \
--lr 0.01 \
--step_lr 500 \
--warmup_steps 1000 \
--gradient_clipping 1.0 \
--loss decov \
--decov_alpha ${SLURM_ARRAY_TASK_ID}'
