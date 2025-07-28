#!/bin/bash
#FLUX: --job-name=frigid-dog-9368
#FLUX: --queue=wildfire
#FLUX: -t=660
#FLUX: --urgency=16

...
nvidia-smi # Useful for seeing GPU status and activity 
python train.py
...
