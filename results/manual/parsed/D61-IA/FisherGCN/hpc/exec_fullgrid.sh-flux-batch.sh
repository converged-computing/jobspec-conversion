#!/bin/bash
#FLUX --job-name=phat-onion-7797
#FLUX --urgency=16

module load tensorflow/1.13.1-py36-gpu
cd gcn && python3 train.py --save $@
