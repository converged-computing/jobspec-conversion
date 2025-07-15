#!/bin/bash
#FLUX: --job-name=gloopy-underoos-8872
#FLUX: -t=900
#FLUX: --urgency=16

module load anaconda
python pytorch_mnist.py
