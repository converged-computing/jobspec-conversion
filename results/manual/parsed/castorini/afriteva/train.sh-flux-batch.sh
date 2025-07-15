#!/bin/bash
#FLUX: --job-name=delicious-diablo-7120
#FLUX: -c=10
#FLUX: -t=604800
#FLUX: --priority=16

export WANDB_MODE='online'
export WANDB_ENTITY='jarmy-naija'
export WANDB_PROJECT='afriteva-v2'

export WANDB_MODE="online"
export WANDB_ENTITY="jarmy-naija"
export WANDB_PROJECT="afriteva-v2"
python3 src/trainer.py training_configs/t5_base.json
