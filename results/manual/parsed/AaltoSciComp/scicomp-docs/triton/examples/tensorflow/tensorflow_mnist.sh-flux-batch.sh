#!/bin/bash
#FLUX --job-name=muffled-plant-0842
#FLUX -t=900
#FLUX --urgency=16

module load scicomp-python-env
python tensorflow_mnist.py
