#!/bin/bash
#FLUX: --job-name=reclusive-cherry-2633
#FLUX: -n=10
#FLUX: --queue=nvidia
#FLUX: -t=172800
#FLUX: --urgency=16

python train.py
