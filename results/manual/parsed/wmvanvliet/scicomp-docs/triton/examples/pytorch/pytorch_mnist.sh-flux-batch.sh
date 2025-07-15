#!/bin/bash
#FLUX: --job-name=dinosaur-platanos-8390
#FLUX: -t=900
#FLUX: --priority=16

module load anaconda
python pytorch_mnist.py
