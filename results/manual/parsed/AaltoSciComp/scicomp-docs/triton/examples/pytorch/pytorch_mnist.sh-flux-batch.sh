#!/bin/bash
#FLUX: --job-name=stinky-lemon-7879
#FLUX: -t=900
#FLUX: --priority=16

module load scicomp-python-env
python pytorch_mnist.py
