#!/bin/bash
#FLUX: --job-name=strawberry-lizard-8477
#FLUX: --urgency=16

module load tensorflow/1.13.1-py36-gpu
cd gcn && python3 train.py --save $@
