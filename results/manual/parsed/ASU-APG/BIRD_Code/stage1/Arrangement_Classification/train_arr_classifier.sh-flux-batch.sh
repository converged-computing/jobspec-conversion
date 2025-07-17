#!/bin/bash
#FLUX: --job-name=angry-blackbean-0520
#FLUX: -n=4
#FLUX: --queue=cidsegpu1
#FLUX: -t=87120
#FLUX: --urgency=16

module load tensorflow/1.8-agave-gpu
cd /home/tgokhale/work/code/Arrangement_Classification
python3 train.py
