#!/bin/bash
#FLUX: --job-name=dinosaur-parsnip-8215
#FLUX: -t=10800
#FLUX: --urgency=16

module load python
source venv/bin/activate
python code/resnet_accuracy.py
