#!/bin/bash
#FLUX: --job-name=joyous-underoos-5433
#FLUX: -N=12
#FLUX: -c=20
#FLUX: --queue=parallel
#FLUX: -t=3600
#FLUX: --urgency=16

module load gcc
module load openmpi
srun python -m mpi4py restrained-ensemble.py 12
