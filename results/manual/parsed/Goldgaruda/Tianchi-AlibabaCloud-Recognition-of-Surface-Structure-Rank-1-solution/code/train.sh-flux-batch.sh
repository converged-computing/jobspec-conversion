#!/bin/bash
#FLUX: --job-name=nerdy-platanos-7281
#FLUX: --priority=16

module purge
source ~/.bashrc
source activate pytorch-1.7.1
python train_upp.py
