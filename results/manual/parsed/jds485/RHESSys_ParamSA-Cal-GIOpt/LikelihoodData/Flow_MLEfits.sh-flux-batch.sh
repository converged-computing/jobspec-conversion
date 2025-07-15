#!/bin/bash
#FLUX: --job-name=stinky-soup-1361
#FLUX: --priority=16

module purge
module load gcc/7.1.0 openmpi/3.1.4 python/3.6.6 mpi4py
mpirun python Flow_MLEfits.py
