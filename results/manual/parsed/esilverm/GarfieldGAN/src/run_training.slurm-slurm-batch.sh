#!/bin/bash
#FLUX: --job-name=stylegan3_garfield_training
#FLUX: -c=12
#FLUX: -t=172800
#FLUX: --urgency=16

module load cuda/11.3.1
module load anaconda3/2020.07
conda init bash
conda env create -f ../stylegan3/environment.yml
conda activate stylegan3
pip install torchvision torch ninja psutil
CUDA_LAUNCH_BLOCKING=1 CXX=g++ python3 ../stylegan3/train.py \
  --outdir=/scratch/$USER/stylegan3-training-runs \
  --cfg=stylegan3-t --data=/scratch/$USER/garfield_images.zip \
  --gpus=4 --batch=32 --gamma=2 --mirror=0 --metrics=none \
  --kimg=125000
