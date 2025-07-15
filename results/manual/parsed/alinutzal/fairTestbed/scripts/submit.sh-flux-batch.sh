#!/bin/bash
#FLUX: --job-name=dinosaur-pedo-6098
#FLUX: -c=20
#FLUX: -t=18000
#FLUX: --priority=16

module load miniconda3
module load cuda/11.8.0
source activate torch
srun --gpu_cmode=exclusive NCCL_P2P_LEVEL=NVL python 3_mnist_pl.py
