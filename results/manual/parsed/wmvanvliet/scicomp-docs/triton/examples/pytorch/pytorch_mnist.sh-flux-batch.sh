#!/bin/bash
#FLUX: --job-name=blank-caramel-5383
#FLUX: -t=900
#FLUX: --urgency=16

module load anaconda
python pytorch_mnist.py
