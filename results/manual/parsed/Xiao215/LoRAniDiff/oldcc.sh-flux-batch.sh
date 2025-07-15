#!/bin/bash
#FLUX: --job-name=salted-blackbean-0802
#FLUX: -c=5
#FLUX: -t=600
#FLUX: --priority=16

CUDA_VISIBLE_DEVICES=0 python3 train.py
