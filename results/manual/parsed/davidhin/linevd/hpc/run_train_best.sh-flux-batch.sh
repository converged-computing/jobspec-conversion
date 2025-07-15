#!/bin/bash
#FLUX: --job-name="lvd"
#FLUX: -t=172800
#FLUX: --priority=16

module load Singularity
module load CUDA/10.2.89
singularity exec -H /g/acvt/a1720858/sastvd --nv main.sif python -u sastvd/scripts/train_best.py
