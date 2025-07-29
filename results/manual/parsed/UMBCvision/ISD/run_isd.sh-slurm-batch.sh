#!/bin/bash
#SBATCH --job-name=isd_5_cos_lr_0x01_m_0x99_aug_ws_mlp_resnet18
#SBATCH --account=pi_hpirsiav
#SBATCH --output=logs/isd_5_cos_lr_0x01_m_0x99_aug_ws_mlp_resnet18.txt
#SBATCH --error=logs/isd_5_cos_lr_0x01_m_0x99_aug_ws_mlp_resnet18.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:4
#SBATCH --mem=100G
#SBATCH --time=9-00:00:00
#SBATCH --partition=gpu
#SBATCH --qos=normal
#SBATCH --constraint=ntasks-per-node=1

set -x
set -e
