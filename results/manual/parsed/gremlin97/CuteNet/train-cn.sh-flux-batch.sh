#!/bin/bash
#FLUX --job-name=bumfuzzled-despacito-5622
#FLUX --queue=wildfire
#FLUX -t=660
#FLUX --urgency=16

...
nvidia-smi # Useful for seeing GPU status and activity 
python train.py
...
