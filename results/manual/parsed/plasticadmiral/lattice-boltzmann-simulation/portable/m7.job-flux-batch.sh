#!/bin/bash
#FLUX: --job-name=hpc
#FLUX: -N=90
#FLUX: --queue=multiple
#FLUX: -t=1800
#FLUX: --urgency=16

module load devel/python/3.8.6_gnu_10.2
module load mpi/openmpi/4.1
SECONDS=0
mpirun -n 3600 python milestone7.py 200000 10000 1000 1000 1.6 0.2 60 60
echo $SECONDS
