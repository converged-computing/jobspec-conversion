#!/bin/bash
#FLUX: --job-name=phat-lettuce-4000
#FLUX: --urgency=16

conda activate keras
module load cuda/10.0
python genCAM.py
