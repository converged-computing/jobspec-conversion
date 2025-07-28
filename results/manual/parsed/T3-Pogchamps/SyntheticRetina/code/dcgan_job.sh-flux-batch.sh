#!/bin/bash
#FLUX: --job-name=gassy-snack-3153
#FLUX: -c=6
#FLUX: -t=180
#FLUX: --urgency=16

module load cuda cudnn
source tensorflow/bin/activate
python3 ./dcgan.py
