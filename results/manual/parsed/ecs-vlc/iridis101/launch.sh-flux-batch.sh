#!/bin/bash
#FLUX: --job-name=wobbly-pastry-2473
#FLUX: -t=240
#FLUX: --urgency=16

module load conda/py3-latest
conda activate my-pytorch-env
python cifar.py
