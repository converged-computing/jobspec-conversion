#!/bin/bash
#FLUX: --job-name=bumfuzzled-general-8094
#FLUX: -t=10800
#FLUX: --urgency=16

module purge
module load python/3.10 scipy-stack
source ~/py310/bin/activate
python exp1/resnet18.py
