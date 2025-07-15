#!/bin/bash
#FLUX: --job-name=dirty-cherry-8556
#FLUX: --queue=maxwell
#FLUX: -t=72000
#FLUX: --priority=16

module load GCC Singularity git
git clone https://github.com/tensorflow/models.git
singularity exec --nv docker://tensorflow/tensorflow:latest-gpu \
    python ./tutorials/image/mnist/convolutional.py
