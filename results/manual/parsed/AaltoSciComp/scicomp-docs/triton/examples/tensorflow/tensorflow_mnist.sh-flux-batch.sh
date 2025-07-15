#!/bin/bash
#FLUX: --job-name=bloated-frito-5281
#FLUX: -t=900
#FLUX: --urgency=16

module load scicomp-python-env
python tensorflow_mnist.py
