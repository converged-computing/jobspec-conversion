#!/bin/bash
#FLUX: --job-name=fat-diablo-5979
#FLUX: -c=256
#FLUX: --queue=ai-jumpstart
#FLUX: --urgency=16

source ~/modules/pytorch/latest
source ~/modules/nccl/nccl_2.9.8-1+cuda11.0_x86_64/source
PL_TORCH_DISTRIBUTED_BACKEND=nccl python train-lightning.py --config-file configs/2D/blind-denoising/dncnn.yaml
