#!/bin/bash
#FLUX: --job-name=stanky-chip-4771
#FLUX: --queue=class
#FLUX: -t=18000
#FLUX: --urgency=16

module load cuda/11.2
source venv/bin/activate
python train.py \
    --model srresnet
