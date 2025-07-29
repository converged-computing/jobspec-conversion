#!/bin/bash
#FLUX --job-name=placid-malarkey-0202
#FLUX -t=18000
#FLUX --urgency=16

module purge
module load python/3.10 scipy-stack
source ~/py310/bin/activate
python exp2/resnet101.py
