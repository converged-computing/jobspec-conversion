#!/bin/bash
#FLUX: --job-name=joyous-underoos-0062
#FLUX: -c=10
#FLUX: -t=604800
#FLUX: --urgency=16

export WANDB_MODE='online'
export WANDB_ENTITY='jarmy-naija'
export WANDB_PROJECT='afriteva-v2'

export WANDB_MODE="online"
export WANDB_ENTITY="jarmy-naija"
export WANDB_PROJECT="afriteva-v2"
python3 src/trainer.py training_configs/t5_base.json
