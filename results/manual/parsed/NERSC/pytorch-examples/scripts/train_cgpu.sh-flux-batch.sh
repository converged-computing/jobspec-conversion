#!/bin/bash
#FLUX: --job-name=purple-frito-4884
#FLUX: -c=10
#FLUX: --gpus-per-task=1
#FLUX: --exclusive
#FLUX: -t=14400
#FLUX: --urgency=16

module load pytorch/v1.5.1-gpu
srun -l -u python train.py -d nccl --rank-gpu $@
