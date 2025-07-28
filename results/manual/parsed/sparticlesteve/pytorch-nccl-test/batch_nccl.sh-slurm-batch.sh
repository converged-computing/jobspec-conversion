#!/bin/bash
#FLUX: --job-name=crusty-salad-5323
#FLUX: -N=2
#FLUX: --gpus-per-task=1
#FLUX: --exclusive
#FLUX: -t=300
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'

module load pytorch/v1.3.1-gpu
module list
export NCCL_DEBUG=INFO
srun -u -l python test_nccl.py
