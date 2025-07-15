#!/bin/bash
#FLUX: --job-name=fuzzy-car-3046
#FLUX: -t=1800
#FLUX: --priority=16

module load scicomp-python-env # use the normal scicomp environment for python
srun python serial.py
