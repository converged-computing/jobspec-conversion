#!/bin/bash
#SBATCH --output=/NS/robustness_2/work/vnanda/invariances_in_reps/deep-learning-base/checkpoints/sbatch_logs/%x_%j.out
#SBATCH --error=/NS/robustness_2/work/vnanda/invariances_in_reps/deep-learning-base/checkpoints/sbatch_logs/%x_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:2
#SBATCH --mem=100GB
#SBATCH --time=4-00:00:00
#SBATCH --partition=a40
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1

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
