#!/bin/bash
#FLUX --job-name=bloated-leg-1400
#FLUX -t=900
#FLUX --urgency=16

module load scicomp-python-env
python pytorch_mnist.py
