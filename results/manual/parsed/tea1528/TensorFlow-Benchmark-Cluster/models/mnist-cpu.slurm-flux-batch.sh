#!/bin/bash
#FLUX: --job-name=fugly-spoon-1627
#FLUX: --queue=maxwell
#FLUX: -t=72000
#FLUX: --priority=16

module load GCC Singularity git
singularity exec --nv docker://tensorflow/tensorflow:latest \
    python ./tutorials/image/mnist/convolutional.py
