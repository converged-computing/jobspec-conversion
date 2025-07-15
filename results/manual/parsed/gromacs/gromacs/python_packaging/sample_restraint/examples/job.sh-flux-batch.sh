#!/bin/bash
#FLUX: --job-name=expressive-omelette-3410
#FLUX: -c=20
#FLUX: --priority=16

module load gcc
module load openmpi
srun python -m mpi4py restrained-ensemble.py 12
