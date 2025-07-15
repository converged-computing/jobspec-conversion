#!/bin/bash
#FLUX: --job-name=traffic
#FLUX: --queue=standard
#FLUX: -t=300
#FLUX: --priority=16

module load cray-python
srun --unbuffered --distribution=block:block --hint=nomultithread \
     python traffic.py
