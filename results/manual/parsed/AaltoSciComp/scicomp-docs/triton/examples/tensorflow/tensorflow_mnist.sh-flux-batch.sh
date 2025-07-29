#!/bin/bash
#FLUX --job-name=fat-hobbit-1453
#FLUX -t=900
#FLUX --urgency=16

module load scicomp-python-env
python tensorflow_mnist.py
