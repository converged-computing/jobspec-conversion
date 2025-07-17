#!/bin/bash
#FLUX: --job-name=kerastest
#FLUX: -c=8
#FLUX: --queue=haswell,sandy,west
#FLUX: -t=7200
#FLUX: --urgency=16

module purge
module load modenv/eb
module load Keras
module load TensorFlow
srun python mnist_cnn.py
