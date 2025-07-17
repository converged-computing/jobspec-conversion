#!/bin/bash
#FLUX: --job-name=faux-motorcycle-5288
#FLUX: -c=80
#FLUX: --exclusive
#FLUX: -t=14400
#FLUX: --urgency=16

module load pytorch/v1.5.0-gpu
srun python train.py ./config.yaml explicit_adv_256_morelate
date
