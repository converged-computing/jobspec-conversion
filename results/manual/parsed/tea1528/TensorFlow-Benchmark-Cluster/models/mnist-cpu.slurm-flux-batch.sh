#!/bin/bash
#FLUX: --job-name=astute-nunchucks-3161
#FLUX: --queue=maxwell
#FLUX: -t=72000
#FLUX: --urgency=16

module load GCC Singularity git
singularity exec --nv docker://tensorflow/tensorflow:latest \
    python ./tutorials/image/mnist/convolutional.py
