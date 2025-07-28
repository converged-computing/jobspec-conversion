#!/bin/bash
#FLUX: --job-name=gassy-lettuce-0520
#FLUX: -n=10
#FLUX: --queue=nvidia
#FLUX: -t=172800
#FLUX: --urgency=16

python train.py
