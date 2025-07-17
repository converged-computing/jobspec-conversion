#!/bin/bash
#FLUX: --job-name=train-cori
#FLUX: --queue=debug
#FLUX: -t=1800
#FLUX: --urgency=16

set -x
srun -l -u shifter python train.py -d $@
