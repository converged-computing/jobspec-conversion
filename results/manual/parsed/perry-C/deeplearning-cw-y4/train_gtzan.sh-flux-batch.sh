#!/bin/bash
#FLUX: --job-name=cw
#FLUX: --queue=teach_gpu
#FLUX: -t=1200
#FLUX: --priority=16

module purge
module load "languages/anaconda3/2021-3.8.8-cuda-11.1-pytorch"
    python3 src/core/train_gtzan.py --reg 0 --aug 1
