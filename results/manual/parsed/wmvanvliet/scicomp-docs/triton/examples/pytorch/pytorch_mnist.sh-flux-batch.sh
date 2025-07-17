#!/bin/bash
#FLUX: --job-name=rainbow-pot-9661
#FLUX: -t=900
#FLUX: --urgency=16

module load anaconda
python pytorch_mnist.py
