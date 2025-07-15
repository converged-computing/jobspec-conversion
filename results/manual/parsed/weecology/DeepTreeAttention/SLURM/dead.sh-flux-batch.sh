#!/bin/bash
#FLUX: --job-name=DeepTreeAttention
#FLUX: -c=30
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

ulimit -c 0
source activate DeepTreeAttention
cd ~/DeepTreeAttention/
module load git gcc
python train_dead.py
