#!/bin/bash
#FLUX: --job-name=hairy-poodle-8835
#FLUX: -t=900
#FLUX: --urgency=16

module load scicomp-python-env
python tensorflow_mnist.py
