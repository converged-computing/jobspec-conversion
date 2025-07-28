#!/bin/bash
#FLUX: --job-name=VAE
#FLUX: -t=14400
#FLUX: --urgency=16

export PYTHONPATH='/home/dongx/anaconda3/envs/env_pytorch/lib/python3.6/site-packages'

source /home/dongx/.bashrc
conda activate /home/dongx/anaconda3/envs/env_pytorch
export PYTHONPATH="$PWD/Unet"
export PYTHONPATH="/home/dongx/anaconda3/envs/env_pytorch/lib/python3.6/site-packages"
srun python3 vae-grid.py
