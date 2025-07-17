#!/bin/bash
#FLUX: --job-name=sticky-leopard-8532
#FLUX: -t=10800
#FLUX: --urgency=16

module load python
source venv/bin/activate
python code/resnet_accuracy.py
