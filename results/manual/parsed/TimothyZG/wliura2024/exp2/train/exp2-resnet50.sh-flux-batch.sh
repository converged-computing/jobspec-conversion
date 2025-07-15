#!/bin/bash
#FLUX: --job-name=lovely-chip-3209
#FLUX: -t=12600
#FLUX: --priority=16

module purge
module load python/3.10 scipy-stack
source ~/py310/bin/activate
python exp2/resnet50.py
