#!/bin/bash
#FLUX: --job-name="empan"
#FLUX: -t=3600
#FLUX: --priority=16

module load Singularity
module load CUDA/10.2.89
singularity exec -H /g/acvt/a1720858/sastvd --nv main.sif python sastvd/linevd/empirical_eval.py
