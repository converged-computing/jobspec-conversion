#!/bin/bash
#FLUX: --job-name=faux-underoos-2769
#FLUX: --urgency=16

module purge
source ~/.bashrc
source activate pytorch-1.7.1
python train_upp.py
