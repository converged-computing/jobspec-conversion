#!/bin/bash
#FLUX: --job-name=peachy-spoon-3143
#FLUX: --queue=bii-gpu
#FLUX: -t=86400
#FLUX: --priority=16

module load singularity pytorch/1.10.0
singularity run --nv $CONTAINERDIR/pytorch-1.10.0.sif generate4kreps.py
