#!/bin/bash
#FLUX: --job-name=swampy-peas-4710
#FLUX: --queue=batch
#FLUX: -t=84600
#FLUX: --urgency=16

source activate /fast/users/a1746546/envs/myenv
module load GCC/5.4.0-2.26
module load CUDA/9.0.176
module load cuDNN/7.3.1-CUDA-9.0.176
cd /fast/users/a1746546/code/DeepLab-v3-plus-cityscapes-Res50
CUDA_VISIBLE_DEVICES=0,1 python -m torch.distributed.launch --nproc_per_node=2 train.py
