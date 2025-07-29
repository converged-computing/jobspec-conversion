#!/bin/bash
#FLUX: --job-name=adorable-sundae-9248
#FLUX: -n=5
#FLUX: --queue=nvidia
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
source ~/.bashrc
source activate pytorch-1.7.1
python train_upp.py
