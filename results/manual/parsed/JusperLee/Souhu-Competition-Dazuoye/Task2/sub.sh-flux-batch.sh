#!/bin/bash
#FLUX: --job-name=strawberry-buttface-1750
#FLUX: --urgency=16

export NCCL_SOCKET_IFNAME='eth0'
export NCCL_IB_DISABLE='1'

export NCCL_SOCKET_IFNAME=eth0
export NCCL_IB_DISABLE=1
module load cuda/10.0
srun python baseline-torch-tf.py --batch_size=2048 --info=25epoch-20decay-bs2048
