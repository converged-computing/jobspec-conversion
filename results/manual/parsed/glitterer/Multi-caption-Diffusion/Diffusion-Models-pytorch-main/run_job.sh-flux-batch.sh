#!/bin/bash
#FLUX: --job-name="class"
#FLUX: -c=4
#FLUX: --queue=gpus
#FLUX: -t=381600
#FLUX: --priority=16

export PYTORCH_CUDA_ALLOC_CONF='expandable_segments:True'

source activate ~/miniconda3/envs/DLproject
export PYTORCH_CUDA_ALLOC_CONF='expandable_segments:True'
cd ~/CSCI2470Project/Multi-caption-Diffusion/Diffusion-Models-pytorch-main
nvidia-smi
python train.py
