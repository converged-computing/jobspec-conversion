#!/bin/bash
#FLUX: --job-name=peachy-lamp-7582
#FLUX: --queue=class
#FLUX: -t=18000
#FLUX: --urgency=16

module load cuda/11.2
source venv/bin/activate
python train.py \
    --model srresnet
