#!/bin/bash
#FLUX: --job-name=blue-platanos-2426
#FLUX: -N=2
#FLUX: -t=36000
#FLUX: --urgency=16

export NCCL_SOCKET_IFNAME='lo'

echo "running in shell: " "$SHELL"
export NCCL_SOCKET_IFNAME=lo
spack load cuda@11.8.0
spack load cudnn@8.6.0.163-11.8
spack load miniconda3
eval "$(conda shell.bash hook)"
conda activate thesis
srun bash ./src/demo_train_rDL_SIM_Model.sh
