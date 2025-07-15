#!/bin/bash
#FLUX: --job-name=hello-hobbit-7474
#FLUX: -t=1800
#FLUX: --urgency=16

module load scicomp-python-env # use the normal scicomp environment for python
srun python serial.py
