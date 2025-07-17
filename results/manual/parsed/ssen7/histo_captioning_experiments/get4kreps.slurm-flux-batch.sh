#!/bin/bash
#FLUX: --job-name=adorable-blackbean-3677
#FLUX: --queue=bii-gpu
#FLUX: -t=86400
#FLUX: --urgency=16

module load singularity pytorch/1.10.0
singularity run --nv $CONTAINERDIR/pytorch-1.10.0.sif generate4kreps.py
