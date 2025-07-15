#!/bin/bash
#FLUX: --job-name=chocolate-pot-7758
#FLUX: --queue=long
#FLUX: -t=172800
#FLUX: --priority=16

export PYTHONUNBUFFERED='1'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/usr/lib/nvidia'
export CPATH='$CONDA_PREFIX/include'

module --quiet load miniconda/3
conda activate qflow_new
wandb login $WANDB_API_KEY
export PYTHONUNBUFFERED=1
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/mila/l/luke.rowe/.mujoco/mujoco210/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/nvidia
export CPATH=$CONDA_PREFIX/include
cd IQL_PyTorch
python main.py --track --env-name hopper-medium-expert-v2 --seed 0
