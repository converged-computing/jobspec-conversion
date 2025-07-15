#!/bin/bash
#FLUX: --job-name=expensive-gato-8119
#FLUX: --priority=16

module purge
module load apptainer tensorflow/2.13.0
apptainer run --nv $CONTAINERDIR/tensorflow-2.13.0.sif tf_example.py
