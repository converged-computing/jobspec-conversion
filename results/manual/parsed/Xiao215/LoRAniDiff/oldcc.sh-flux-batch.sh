#!/bin/bash
#FLUX: --job-name=astute-buttface-0824
#FLUX: -c=5
#FLUX: -t=600
#FLUX: --urgency=16

CUDA_VISIBLE_DEVICES=0 python3 train.py
