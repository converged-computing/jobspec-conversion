#!/bin/bash
#FLUX: --job-name=chocolate-house-6976
#FLUX: --urgency=16

module load tensorflow/1.8-agave-gpu
cd /home/tgokhale/work/code/Arrangement_Classification
python3 train.py
