#!/bin/bash
#FLUX: --job-name=misunderstood-platanos-1912
#FLUX: -c=8
#FLUX: --urgency=16

export PYTHONUNBUFFERED='1'

pwd
hostname
date
nvidia-smi
echo "Starting SwinIR training job (classical SR)..."
source ~/.bashrc
conda activate image-sr
export PYTHONUNBUFFERED=1
CUDA_VISIBLE_DEVICES=0,1,2,3,4,5 python3 -m torch.distributed.launch --nproc_per_node=3 --master_port=1234 main_train_psnr.py --opt /home/zeeshan/image-sr/options/swinir/train_swinir_sr_classical.json --dist False
date
