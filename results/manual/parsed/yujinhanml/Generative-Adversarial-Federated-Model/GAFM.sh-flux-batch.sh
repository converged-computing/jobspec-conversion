#!/bin/bash
#FLUX: --job-name=GAFM
#FLUX: --queue=gpu
#FLUX: --urgency=16

python train.py
