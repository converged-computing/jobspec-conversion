#!/bin/bash
#FLUX: --job-name=sticky-soup-6719
#FLUX: --priority=16

module load tensorflow/1.13.1-py36-gpu
cd gcn && python3 train.py --save $@
