#!/bin/bash
#FLUX: --job-name=boopy-truffle-4185
#FLUX: -t=900
#FLUX: --urgency=16

module load scicomp-python-env
python tensorflow_mnist.py
