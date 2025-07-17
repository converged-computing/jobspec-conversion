#!/bin/bash
#FLUX: --job-name=stanky-leader-1038
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

module load singularity tensorflow/2.10.0
singularity run --nv $CONTAINERDIR/tensorflow-2.10.0.sif transformer_age2.py
