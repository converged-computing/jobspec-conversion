#!/bin/bash
#FLUX: --job-name=grated-chip-3970
#FLUX: -t=240
#FLUX: --priority=16

module load conda/py3-latest
conda activate my-pytorch-env
python cifar.py
