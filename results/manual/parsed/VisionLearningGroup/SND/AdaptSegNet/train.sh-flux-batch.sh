#!/bin/bash
#FLUX: --job-name=fugly-banana-8136
#FLUX: --queue=gpu-L --gres=gpu:1 --constraint="24G" --cpus-per-gpu=5
#FLUX: --priority=16

d=$(date)
echo $d nvidia-smi
nvidia-smi
hostn=$(hostname -s)
cd /home/grad3/keisaito/domain_adaptation/AdaptSegNet
source activate pytorch
CUDA_VISIBLE_DEVICES=$1 python run_all.py --snapshot-dir ./snapshots/GTA2Cityscapes_single --lambda-seg 0.1 --gpu 1
