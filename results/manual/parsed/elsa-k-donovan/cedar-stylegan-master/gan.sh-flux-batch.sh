#!/bin/bash
#FLUX: --job-name=persnickety-fork-1842
#FLUX: -c=6
#FLUX: -t=610560
#FLUX: --urgency=16

module load cuda cudnn
source /home/edonovan/tensorflow/bin/activate
python train.py
