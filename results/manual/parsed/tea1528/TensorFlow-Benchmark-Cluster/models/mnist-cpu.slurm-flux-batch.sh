#!/bin/bash
#FLUX --job-name=salted-egg-1607
#FLUX --queue=maxwell
#FLUX -t=72000
#FLUX --urgency=16

module load GCC Singularity git
singularity exec --nv docker://tensorflow/tensorflow:latest \
    python ./tutorials/image/mnist/convolutional.py
