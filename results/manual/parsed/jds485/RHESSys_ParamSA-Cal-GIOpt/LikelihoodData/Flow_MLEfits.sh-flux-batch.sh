#!/bin/bash
#FLUX: --job-name=chocolate-butter-3121
#FLUX: -N=20
#FLUX: --queue=parallel
#FLUX: -t=18000
#FLUX: --urgency=16

module purge
module load gcc/7.1.0 openmpi/3.1.4 python/3.6.6 mpi4py
mpirun python Flow_MLEfits.py
