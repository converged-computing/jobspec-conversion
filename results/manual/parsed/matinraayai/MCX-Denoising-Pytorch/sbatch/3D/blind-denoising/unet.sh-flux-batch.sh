#!/bin/bash
#FLUX: --job-name=quirky-cat-7181
#FLUX: --priority=16

source ~/modules/pytorch/latest
source ~/modules/nccl/nccl_2.9.8-1+cuda11.0_x86_64/source
PL_TORCH_DISTRIBUTED_BACKEND=nccl python train-lightning.py --config-file configs/3D/blind-denoising/unet.yaml
