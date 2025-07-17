#!/bin/bash
#FLUX: --job-name=evasive-rabbit-0168
#FLUX: -c=10
#FLUX: --gpus-per-task=1
#FLUX: -t=14400
#FLUX: --urgency=16

nproc_per_node=1
config=bs128-opt
module load cgpu
module load pytorch/1.7.0-gpu
srun -N 1 -n 1 python -m torch.distributed.launch --nproc_per_node=$nproc_per_node \
    train.py --config=$config
