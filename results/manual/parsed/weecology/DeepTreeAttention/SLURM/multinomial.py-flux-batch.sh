#!/bin/bash
#FLUX: --job-name=multinomial
#FLUX: -t=172800
#FLUX: --urgency=16

source activate DeepTreeAttention
cd ~/DeepTreeAttention/
python sample_multinomial.py
