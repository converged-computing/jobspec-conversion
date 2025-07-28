#!/bin/bash
#FLUX: --job-name=quirky-sundae-8342
#FLUX: -t=900
#FLUX: --urgency=16

module load scicomp-python-env
python pytorch_mnist.py
