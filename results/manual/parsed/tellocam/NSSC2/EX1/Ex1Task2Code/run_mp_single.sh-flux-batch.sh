#!/bin/bash
#FLUX: --job-name=jacobiMPI
#FLUX: --exclusive
#FLUX: -t=600
#FLUX: --urgency=16

if command -v sinfo  2>/dev/null # if on cluster
then
    module load mpi/openmpi-x86_64
    module load pmi/pmix-x86_64
    mpiproc=20
else  # if on local machine
    mpiproc=8
fi
mpirun -n $mpiproc ./jacobiMPI 128 1000
