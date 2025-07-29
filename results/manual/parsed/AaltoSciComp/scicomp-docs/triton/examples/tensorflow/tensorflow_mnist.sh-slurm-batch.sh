#!/bin/bash
#FLUX: --job-name=phat-snack-1407
#FLUX: -t=900
#FLUX: --urgency=16

module load scicomp-python-env
python tensorflow_mnist.py
