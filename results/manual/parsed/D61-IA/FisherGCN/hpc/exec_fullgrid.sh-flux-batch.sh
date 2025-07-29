#!/bin/bash
#FLUX --job-name=wobbly-pancake-9587
#FLUX --urgency=16

module load tensorflow/1.13.1-py36-gpu
cd gcn && python3 train.py --save $@
