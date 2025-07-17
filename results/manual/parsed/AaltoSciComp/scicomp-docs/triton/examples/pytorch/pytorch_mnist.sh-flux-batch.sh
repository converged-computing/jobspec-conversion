#!/bin/bash
#FLUX: --job-name=goodbye-cinnamonbun-2616
#FLUX: -t=900
#FLUX: --urgency=16

module load scicomp-python-env
python pytorch_mnist.py
