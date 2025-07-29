#!/bin/bash
#FLUX: --job-name=pytorch_primary
#FLUX: -c=4
#FLUX: --queue=GPU
#FLUX: -t=1800000
#FLUX: --urgency=16

srun python train.py
