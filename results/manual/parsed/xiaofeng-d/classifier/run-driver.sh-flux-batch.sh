#!/bin/bash
#FLUX: --job-name=classifier
#FLUX: -t=600
#FLUX: --priority=16

export PYTHONPATH='$PWD/Unet'

source /home/dongx/.bashrc
conda activate /home/dongx/anaconda3/envs/env_pytorch
export PYTHONPATH="$PWD/Unet"
srun --ntasks-per-node=1 --gpus-per-task=1 ./driver.py
