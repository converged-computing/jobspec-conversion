#!/bin/bash
#FLUX: --job-name=pytorch_BLOCKATTENTION
#FLUX: -t=28800
#FLUX: --priority=16

module load cuda/9.0.176
module load pytorch/1.1.0-py36-cuda90
python Pytorch_Seq2Seq/main.py
