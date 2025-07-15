#!/bin/bash
#FLUX: --job-name=phat-itch-0169
#FLUX: --urgency=16

...
nvidia-smi # Useful for seeing GPU status and activity 
python train.py
...
