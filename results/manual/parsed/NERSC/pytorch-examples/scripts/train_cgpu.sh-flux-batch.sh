#!/bin/bash
#FLUX: --job-name=outstanding-malarkey-3138
#FLUX: -c=10
#FLUX: --gpus-per-task=1
#FLUX: --exclusive
#FLUX: -t=14400
#FLUX: --priority=16

module load pytorch/v1.5.1-gpu
srun -l -u python train.py -d nccl --rank-gpu $@
