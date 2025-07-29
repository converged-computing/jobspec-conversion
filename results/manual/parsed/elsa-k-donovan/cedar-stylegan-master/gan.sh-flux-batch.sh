#!/bin/bash
#FLUX --job-name=bricky-bike-4757
#FLUX -c=6
#FLUX -t=610560
#FLUX --urgency=16

module load cuda cudnn
source /home/edonovan/tensorflow/bin/activate
python train.py
