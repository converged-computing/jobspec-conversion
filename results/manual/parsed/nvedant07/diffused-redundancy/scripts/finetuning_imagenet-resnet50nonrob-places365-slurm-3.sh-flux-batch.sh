#!/bin/bash
#FLUX: --job-name=reclusive-malarkey-7956
#FLUX: --urgency=16

srun --jobid $SLURM_JOBID bash -c 'python -m partially_inverted_reps.finetuning \
--source_dataset imagenet \
--wandb_name partial_finetuning \
--finetuning_dataset places365 \
--finetune_mode linear \
--model resnet50 \
--batch_size 1024 \
--append_path nonrob \
--epochs 15 \
--mode random \
--pretrained True \
--step_lr 3 \
--fraction 0.1 \
--seed ${SLURM_ARRAY_TASK_ID}'
srun --jobid $SLURM_JOBID bash -c 'python -m partially_inverted_reps.finetuning \
--source_dataset imagenet \
--wandb_name partial_finetuning \
--finetuning_dataset places365 \
--finetune_mode linear \
--model resnet50 \
--batch_size 1024 \
--append_path nonrob \
--epochs 15 \
--mode random \
--pretrained True \
--step_lr 3 \
--fraction 0.2 \
--seed ${SLURM_ARRAY_TASK_ID}'
srun --jobid $SLURM_JOBID bash -c 'python -m partially_inverted_reps.finetuning \
--source_dataset imagenet \
--wandb_name partial_finetuning \
--finetuning_dataset places365 \
--finetune_mode linear \
--model resnet50 \
--batch_size 1024 \
--append_path nonrob \
--epochs 15 \
--mode random \
--pretrained True \
--step_lr 3 \
--fraction 0.3 \
--seed ${SLURM_ARRAY_TASK_ID}'
srun --jobid $SLURM_JOBID bash -c 'python -m partially_inverted_reps.finetuning \
--source_dataset imagenet \
--wandb_name partial_finetuning \
--finetuning_dataset places365 \
--finetune_mode linear \
--model resnet50 \
--batch_size 1024 \
--append_path nonrob \
--epochs 15 \
--mode random \
--pretrained True \
--step_lr 3 \
--fraction 0.5 \
--seed ${SLURM_ARRAY_TASK_ID}'
srun --jobid $SLURM_JOBID bash -c 'python -m partially_inverted_reps.finetuning \
--source_dataset imagenet \
--wandb_name partial_finetuning \
--finetuning_dataset places365 \
--finetune_mode linear \
--model resnet50 \
--batch_size 1024 \
--append_path nonrob \
--epochs 15 \
--mode random \
--pretrained True \
--step_lr 3 \
--fraction 0.8 \
--seed ${SLURM_ARRAY_TASK_ID}'
srun --jobid $SLURM_JOBID bash -c 'python -m partially_inverted_reps.finetuning \
--source_dataset imagenet \
--wandb_name partial_finetuning \
--finetuning_dataset places365 \
--finetune_mode linear \
--model resnet50 \
--batch_size 1024 \
--append_path nonrob \
--epochs 15 \
--mode random \
--pretrained True \
--step_lr 3 \
--fraction 0.9 \
--seed ${SLURM_ARRAY_TASK_ID}'
