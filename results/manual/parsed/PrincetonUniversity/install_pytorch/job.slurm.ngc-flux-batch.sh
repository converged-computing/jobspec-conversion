#!/bin/bash
#FLUX: --job-name=pytorch-ngc
#FLUX: -t=120
#FLUX: --urgency=16

module purge
singularity exec --nv $HOME/software/pytorch_23.09-py3.sif python3 mnist_classify.py --epochs=3
