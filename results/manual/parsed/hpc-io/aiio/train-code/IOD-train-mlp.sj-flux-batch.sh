#!/bin/bash
#FLUX: --job-name=frigid-frito-6037
#FLUX: --gpus-per-task=4
#FLUX: --priority=16

export MPICH_GPU_SUPPORT_ENABLED='0'

module load tensorflow
module list
set -x
export MPICH_GPU_SUPPORT_ENABLED=0
srun -l -u python ./IOD-train-mlp.py
