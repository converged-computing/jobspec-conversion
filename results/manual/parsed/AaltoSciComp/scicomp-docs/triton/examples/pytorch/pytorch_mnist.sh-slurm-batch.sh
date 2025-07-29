#!/bin/bash
#FLUX: --job-name=psycho-lizard-9792
#FLUX: -t=900
#FLUX: --urgency=16

module load scicomp-python-env
python pytorch_mnist.py
