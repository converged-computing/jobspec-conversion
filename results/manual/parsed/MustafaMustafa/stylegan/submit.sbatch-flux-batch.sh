#!/bin/bash
#FLUX: --job-name=loopy-despacito-8481
#FLUX: -t=7200
#FLUX: --priority=16

module load cuda
module load nccl
module load tensorflow/gpu-1.13.0-py36
cd /project/projectdirs/dasrepo/mustafa/stylegan 
python train.py
