#!/bin/bash
#FLUX: --job-name=nerdy-destiny-6282
#FLUX: -N=15
#FLUX: --queue=parallel
#FLUX: -t=7200
#FLUX: --urgency=16

module purge
module load gcc/7.1.0 openmpi/3.1.4 python/3.6.6 mpi4py
mpirun python TN_MLEfits.py
