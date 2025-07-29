#!/bin/bash
#FLUX: --job-name=stanky-bicycle-2843
#FLUX: -t=900
#FLUX: --urgency=16

module load anaconda
python pytorch_mnist.py
