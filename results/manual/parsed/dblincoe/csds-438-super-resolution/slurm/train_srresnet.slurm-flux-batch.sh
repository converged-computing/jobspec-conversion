#!/bin/bash
#FLUX: --job-name=misunderstood-bicycle-4351
#FLUX: --urgency=16

module load cuda/11.2
source venv/bin/activate
python train.py \
    --model srresnet
