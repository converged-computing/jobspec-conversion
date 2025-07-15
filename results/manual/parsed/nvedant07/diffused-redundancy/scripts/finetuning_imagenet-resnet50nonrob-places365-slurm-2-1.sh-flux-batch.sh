#!/bin/bash
#FLUX: --job-name=delicious-banana-6641
#FLUX: --priority=16

srun --jobid $SLURM_JOBID bash -c 'python -m partially_inverted_reps.finetuning \
--source_dataset imagenet \
--wandb_name partial_finetuning \
--finetuning_dataset places365 \
--finetune_mode linear \
--model resnet50 \
--batch_size 1024 \
--append_path nonrob \
--epochs 50 \
--mode random \
--pretrained True \
--step_lr 5 \
--fraction 0.004 \
--seed ${SLURM_ARRAY_TASK_ID}'
srun --jobid $SLURM_JOBID bash -c 'python -m partially_inverted_reps.finetuning \
--source_dataset imagenet \
--wandb_name partial_finetuning \
--finetuning_dataset places365 \
--finetune_mode linear \
--model resnet50 \
--batch_size 1024 \
--append_path nonrob \
--epochs 50 \
--mode random \
--pretrained True \
--step_lr 5 \
--fraction 0.005 \
--seed ${SLURM_ARRAY_TASK_ID}'
srun --jobid $SLURM_JOBID bash -c 'python -m partially_inverted_reps.finetuning \
--source_dataset imagenet \
--wandb_name partial_finetuning \
--finetuning_dataset places365 \
--finetune_mode linear \
--model resnet50 \
--batch_size 1024 \
--append_path nonrob \
--epochs 50 \
--mode random \
--pretrained True \
--step_lr 5 \
--fraction 0.01 \
--seed ${SLURM_ARRAY_TASK_ID}'
srun --jobid $SLURM_JOBID bash -c 'python -m partially_inverted_reps.finetuning \
--source_dataset imagenet \
--wandb_name partial_finetuning \
--finetuning_dataset places365 \
--finetune_mode linear \
--model resnet50 \
--batch_size 1024 \
--append_path nonrob \
--epochs 50 \
--mode random \
--pretrained True \
--step_lr 5 \
--fraction 0.05 \
--seed ${SLURM_ARRAY_TASK_ID}'
