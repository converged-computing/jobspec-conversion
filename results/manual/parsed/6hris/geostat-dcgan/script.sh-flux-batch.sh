#!/bin/bash
#FLUX: --job-name=dcgan_model
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu
#FLUX: -t=43200
#FLUX: --priority=16

export NCCL_P2P_DISABLE='1'

pwd; hostname; date
module load conda
conda activate pytorch-gan
export NCCL_P2P_DISABLE=1
python3 dcgan.py
date
