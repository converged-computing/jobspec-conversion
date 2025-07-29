#!/bin/bash
#FLUX: --job-name=goodbye-latke-5054
#FLUX: -t=12600
#FLUX: --urgency=16

module purge
module load python/3.10 scipy-stack
source ~/py310/bin/activate
python exp2/resnet50.py
