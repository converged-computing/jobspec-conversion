#!/bin/bash
#FLUX: --job-name=salted-pastry-9549
#FLUX: --urgency=16

module load tensorflow/1.13.1-py36-gpu
cd gcn && python3 train.py --save $@
