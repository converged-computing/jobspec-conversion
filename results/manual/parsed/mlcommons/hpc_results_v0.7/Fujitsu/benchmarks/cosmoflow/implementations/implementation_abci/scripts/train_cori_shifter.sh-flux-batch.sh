#!/bin/bash
#FLUX: --job-name=muffled-butter-1672
#FLUX: --urgency=16

set -x
srun -l -u shifter python train.py -d $@
