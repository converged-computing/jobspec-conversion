#!/bin/bash
#FLUX: --job-name=strawberry-truffle-9799
#FLUX: -c=32
#FLUX: --queue=ecsstudents
#FLUX: -t=240
#FLUX: --urgency=16

module load conda/py3-latest
conda activate my-pytorch-env
python cifar.py
