#!/bin/bash
#SBATCH --output=/NS/robustness_2/work/vnanda/invariances_in_reps/deep-learning-base/checkpoints/sbatch_logs/%x_%j.out
#SBATCH --error=/NS/robustness_2/work/vnanda/invariances_in_reps/deep-learning-base/checkpoints/sbatch_logs/%x_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:2
#SBATCH --mem=100GB
#SBATCH --time=4-00:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=5

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
