#!/bin/bash
#FLUX: --job-name=gloopy-pot-8414
#FLUX: --priority=16

conda activate keras
module load cuda/10.0
python genCAM.py
