#!/bin/bash
#FLUX: --job-name=frigid-destiny-9074
#FLUX: --priority=16

module load cuda/11.2
source venv/bin/activate
python train.py \
    --model srresnet
