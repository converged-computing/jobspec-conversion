#!/bin/bash
#FLUX: --job-name=crunchy-lettuce-8179
#FLUX: --gpus-per-task=1
#FLUX: --exclusive
#FLUX: --priority=16

export NCCL_DEBUG='INFO'

module load pytorch/v1.3.1-gpu
module list
export NCCL_DEBUG=INFO
srun -u -l python test_nccl.py
