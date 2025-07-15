#!/bin/bash
#FLUX: --job-name=hello-lizard-3849
#FLUX: --queue=gpu-L
#FLUX: --urgency=16

d=$(date)
echo $d nvidia-smi
nvidia-smi
hostn=$(hostname -s)
cd /home/grad3/keisaito/domain_adaptation/AdaptSegNet
source activate pytorch
CUDA_VISIBLE_DEVICES=$1 python run_all.py --snapshot-dir ./snapshots/GTA2Cityscapes_single --lambda-seg 0.1 --gpu 1
