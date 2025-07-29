#!/bin/bash
#SBATCH --account=def-kshook
#SBATCH --output=logs/train_afrit5_base_am_ha_sw.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:a100:2
#SBATCH --mem=256G
#SBATCH --time=7-00:00:00

export WANDB_MODE='online'
export WANDB_ENTITY='jarmy-naija'
export WANDB_PROJECT='afriteva-v2'

export WANDB_MODE="online"
export WANDB_ENTITY="jarmy-naija"
export WANDB_PROJECT="afriteva-v2"
python3 src/trainer.py training_configs/t5_base.json
