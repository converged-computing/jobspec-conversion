#!/bin/bash
#FLUX: --job-name=selfsupervised
#FLUX: -t=172800
#FLUX: --urgency=16

source activate DeepTreeAttention
cd ~/DeepTreeAttention/
python notebooks/crop_random_tile.py
