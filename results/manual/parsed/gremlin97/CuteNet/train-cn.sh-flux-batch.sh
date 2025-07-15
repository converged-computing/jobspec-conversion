#!/bin/bash
#FLUX: --job-name=blank-caramel-0651
#FLUX: --priority=16

...
nvidia-smi # Useful for seeing GPU status and activity 
python train.py
...
