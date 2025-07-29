#!/bin/bash
#SBATCH --job-name=isd_6_plus_tt_0x02_ts_0x20_cos_lr_0x01_m_0x99_aug_ws_mlp_resnet18
#SBATCH --account=pi_hpirsiav
#SBATCH --output=logs/isd_6_plus_tt_0x02_ts_0x20_cos_lr_0x01_m_0x99_aug_ws_mlp_resnet18.txt
#SBATCH --error=logs/isd_6_plus_tt_0x02_ts_0x20_cos_lr_0x01_m_0x99_aug_ws_mlp_resnet18.txt
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
python train_isd_plus.py \
    --momentum 0.99 \
    --temp_t 0.02 \
    --temp_s 0.20 \
    --learning_rate 0.01 \
    --cos \
    --arch resnet18 \
    --augmentation 'weak/strong' \
    --checkpoint_path output/isd_6_plus_tt_0x02_ts_0x20_cos_lr_0x01_m_0x99_aug_ws_mlp_resnet18 \
    /nfs/ada/hpirsiav/datasets/imagenet
