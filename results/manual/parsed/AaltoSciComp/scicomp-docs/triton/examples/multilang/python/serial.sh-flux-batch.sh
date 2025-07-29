#!/bin/bash
#FLUX --job-name=gassy-banana-4073
#FLUX -t=1800
#FLUX --urgency=16

module load scicomp-python-env # use the normal scicomp environment for python
srun python serial.py
