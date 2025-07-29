#!/bin/bash
#SBATCH --output=/NS/robustness_2/work/vnanda/invariances_in_reps/deep-learning-base/checkpoints/sbatch_logs/%x_%j.out
#SBATCH --error=/NS/robustness_2/work/vnanda/invariances_in_reps/deep-learning-base/checkpoints/sbatch_logs/%x_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:2
#SBATCH --mem=100GB
#SBATCH --time=4-00:00:00
#SBATCH --partition=a100
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=2-5

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
