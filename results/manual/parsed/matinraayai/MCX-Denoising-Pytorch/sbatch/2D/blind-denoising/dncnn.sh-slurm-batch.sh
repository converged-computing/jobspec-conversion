#!/bin/bash
#SBATCH --output=sbatch_outputs/2D_blind_dncnn_%j.out
#SBATCH --error=sbatch_outputs/2D_blind_dncnn_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=256
#SBATCH --gres=gpu:a100:8
#SBATCH --mem=100000

source ~/modules/pytorch/latest
source ~/modules/nccl/nccl_2.9.8-1+cuda11.0_x86_64/source
PL_TORCH_DISTRIBUTED_BACKEND=nccl python train-lightning.py --config-file configs/2D/blind-denoising/dncnn.yaml
