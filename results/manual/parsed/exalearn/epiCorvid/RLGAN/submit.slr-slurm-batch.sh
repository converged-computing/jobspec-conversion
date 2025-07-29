#!/bin/bash
#FLUX: --job-name=faux-sundae-0264
#FLUX: -c=80
#FLUX: --exclusive
#FLUX: -t=14400
#FLUX: --urgency=16

module load pytorch/v1.5.0-gpu
srun python train.py ./config.yaml explicit_G512
date
