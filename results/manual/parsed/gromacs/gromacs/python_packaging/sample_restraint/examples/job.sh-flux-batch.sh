#!/bin/bash
#FLUX: --job-name=blank-eagle-9291
#FLUX: -c=20
#FLUX: --urgency=16

module load gcc
module load openmpi
srun python -m mpi4py restrained-ensemble.py 12
