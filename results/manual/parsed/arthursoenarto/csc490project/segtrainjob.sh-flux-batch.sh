#!/bin/bash
#FLUX --job-name=conspicuous-general-4304
#FLUX -t=10800
#FLUX --urgency=16

module load python
source venv/bin/activate
python code/resnet_accuracy.py
