#!/bin/bash
#FLUX --job-name=scruptious-itch-1630
#FLUX -t=900
#FLUX --urgency=16

module load anaconda
python pytorch_mnist.py
