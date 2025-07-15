#!/bin/bash
#FLUX: --job-name=bricky-buttface-7535
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
module load python/3.10 scipy-stack
source ~/py310/bin/activate
python exp3/train/resnet18.py
