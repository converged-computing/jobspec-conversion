#!/bin/bash
#FLUX: --job-name=train
#FLUX: -c=8
#FLUX: -t=172800
#FLUX: --priority=16

module load gcc/9.3.0 cuda/11.8.0 cudacore/.11.8.0 cudnn/8.6.0.163 arrow/10.0.1 python/3.10 opencv
pip install -r requirements.txt 
CUDA_VISIBLE_DEVICES=0 python rainbow.py Alien-v5 Boxing-v5 Breakout-v5 --seed=$RANDOM --optimizer=cadam_noise --beta0 0.6 
