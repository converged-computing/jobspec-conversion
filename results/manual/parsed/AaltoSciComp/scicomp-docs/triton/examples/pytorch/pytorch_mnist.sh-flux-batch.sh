#!/bin/bash
#FLUX --job-name=fugly-spoon-8522
#FLUX -t=900
#FLUX --urgency=16

module load scicomp-python-env
python pytorch_mnist.py
