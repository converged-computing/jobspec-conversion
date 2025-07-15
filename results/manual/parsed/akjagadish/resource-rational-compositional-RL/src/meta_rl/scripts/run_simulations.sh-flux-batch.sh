#!/bin/bash
#FLUX: --job-name=RL3
#FLUX: -c=8
#FLUX: -t=144000
#FLUX: --priority=16

cd ~/RL3NeurIPS/
module purge
conda activate pytorch-gpu
python simulate.py.py --entropy --prior svdo --num-episodes 400 --changepoint --per-trial 0
