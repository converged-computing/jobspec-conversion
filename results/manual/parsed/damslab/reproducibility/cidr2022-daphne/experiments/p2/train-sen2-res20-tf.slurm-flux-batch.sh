#!/bin/bash
#FLUX: --job-name=quirky-bits-0530
#FLUX: -t=45296
#FLUX: --urgency=16

cd ~/local
pwd; hostname; date
source ~/daphne/venv/bin/activate
cd ~/daphne/experiments
time python3 resnet20-training.py dataset=sen2 datadir=~/local 
date
