#!/bin/bash
#FLUX: --job-name=milky-train-2441
#FLUX: --priority=16

set -x
srun -l -u shifter python train.py -d $@
