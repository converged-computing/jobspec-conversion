#!/bin/bash
#FLUX: --job-name=wobbly-butter-9953
#FLUX: -c=16
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --priority=16

eval "$(conda shell.bash hook)"
conda activate mm
cd /home1/tereeves/mm/DepressionDetection
python train.py
