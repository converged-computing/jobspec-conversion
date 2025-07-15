#!/bin/bash
#FLUX: --job-name=peachy-poodle-1467
#FLUX: -t=900
#FLUX: --priority=16

module load scicomp-python-env
python tensorflow_mnist.py
