#!/bin/bash
#FLUX --job-name=confused-chip-0635
#FLUX -t=900
#FLUX --urgency=16

module load anaconda
python pytorch_mnist.py
