#!/bin/bash
#FLUX: --job-name=gloopy-soup-7645
#FLUX: -t=900
#FLUX: --urgency=16

module load scicomp-python-env
python pytorch_mnist.py
