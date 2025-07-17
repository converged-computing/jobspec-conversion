#!/bin/bash
#FLUX: --job-name=rqT
#FLUX: -n=2
#FLUX: --queue=batch
#FLUX: -t=172800
#FLUX: --urgency=16

module load Singularity
module load CUDA/10.2.89
singularity exec -H /g/acvt/a1720858/sastvd --nv main.sif python -u sastvd/scripts/rqtest.py
