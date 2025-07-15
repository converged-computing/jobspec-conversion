#!/bin/bash
#FLUX: --job-name=lab2
#FLUX: --queue=teach_gpu
#FLUX: -t=1200
#FLUX: --priority=16

module purge
module load "languages/anaconda3/2021-3.8.8-cuda-11.1-pytorch"
python train_cifar.py
