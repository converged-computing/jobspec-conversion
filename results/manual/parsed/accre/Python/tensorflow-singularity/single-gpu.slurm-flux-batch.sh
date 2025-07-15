#!/bin/bash
#FLUX: --job-name=blue-pot-4314
#FLUX: --queue=pascal
#FLUX: -t=43200
#FLUX: --priority=16

module load GCC Singularity git
git clone https://github.com/tensorflow/models.git
singularity exec --nv docker://tensorflow/tensorflow:latest-gpu \
    python ./models/tutorials/image/mnist/convolutional.py
