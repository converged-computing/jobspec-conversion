#!/bin/bash
#FLUX: --job-name=eccentric-leg-9085
#FLUX: -t=7200
#FLUX: --urgency=16

module purge
module load python/3.10 scipy-stack
source ~/py310/bin/activate
CUDA_LAUNCH_BLOCKING=1 python exp2/resnet18.py
