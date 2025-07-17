#!/bin/bash
#FLUX: --job-name=rainbow-eagle-6056
#FLUX: -n=10
#FLUX: --queue=nvidia
#FLUX: -t=172800
#FLUX: --urgency=16

python train.py
