#!/bin/bash
#FLUX: --job-name=gassy-lettuce-3324
#FLUX: -c=8
#FLUX: -t=7200
#FLUX: --urgency=16

module purge
module load modenv/eb
module load Keras
module load TensorFlow
srun python mnist_cnn.py
