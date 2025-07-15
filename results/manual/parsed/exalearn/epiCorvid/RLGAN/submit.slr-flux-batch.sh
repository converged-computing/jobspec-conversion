#!/bin/bash
#FLUX: --job-name=chunky-animal-6024
#FLUX: --exclusive
#FLUX: -t=14400
#FLUX: --urgency=16

module load pytorch/v1.5.0-gpu
srun python train.py ./config.yaml explicit_G512
date
