#!/bin/bash
#FLUX: --job-name="train"
#FLUX: -c=32
#FLUX: --queue=a100      # <- or one of: a100 sandy
#FLUX: -t=172800
#FLUX: --priority=16

export WANDB_API_KEY='6503c82b63d216d89775a9c56d0a24fb8fd19580'

nvidia-smi
source ~/.bashrc
export WANDB_API_KEY=6503c82b63d216d89775a9c56d0a24fb8fd19580
python train.py
