#!/bin/bash
#FLUX: --job-name=crunchy-lemon-3452
#FLUX: -t=7200
#FLUX: --urgency=16

module load cuda
module load nccl
module load tensorflow/gpu-1.13.0-py36
cd /project/projectdirs/dasrepo/mustafa/stylegan 
python train.py
