#!/bin/bash
#FLUX: --job-name=fugly-house-7699
#FLUX: -c=6
#FLUX: -t=180
#FLUX: --urgency=16

module load cuda cudnn
source tensorflow/bin/activate
python3 ./dcgan.py
