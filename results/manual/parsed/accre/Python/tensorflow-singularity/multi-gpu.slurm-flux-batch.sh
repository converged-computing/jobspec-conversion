#!/bin/bash
#FLUX: --job-name=cowy-train-5505
#FLUX: --queue=pascal
#FLUX: -t=43200
#FLUX: --urgency=16

module load GCC Singularity git
git clone https://github.com/tensorflow/models.git
singularity exec --nv docker://tensorflow/tensorflow:latest-gpu \
    python ./models/tutorials/image/mnist/convolutional.py
