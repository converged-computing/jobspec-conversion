#!/bin/bash
#FLUX: --job-name=joyous-car-2489
#FLUX: --urgency=16

module purge
module load apptainer tensorflow/2.13.0
apptainer run --nv $CONTAINERDIR/tensorflow-2.13.0.sif tf_example.py
