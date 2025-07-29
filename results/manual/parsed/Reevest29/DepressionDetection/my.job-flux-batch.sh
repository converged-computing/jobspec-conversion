#!/bin/bash
#FLUX --job-name=red-mango-8889
#FLUX -c=16
#FLUX --queue=gpu
#FLUX -t=172800
#FLUX --urgency=16

eval "$(conda shell.bash hook)"
conda activate mm
cd /home1/tereeves/mm/DepressionDetection
python train.py
