#!/bin/bash
#FLUX: --job-name=dinosaur-sundae-4375
#FLUX: --priority=16

module load tensorflow/1.8-agave-gpu
cd /home/tgokhale/work/code/Arrangement_Classification
python3 train.py
