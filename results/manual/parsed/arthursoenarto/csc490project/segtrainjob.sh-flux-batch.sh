#!/bin/bash
#FLUX: --job-name=strawberry-bits-4891
#FLUX: -t=10800
#FLUX: --priority=16

module load python
source venv/bin/activate
python code/resnet_accuracy.py
