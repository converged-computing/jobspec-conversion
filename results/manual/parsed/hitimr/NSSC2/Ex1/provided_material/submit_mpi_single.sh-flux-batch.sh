#!/bin/bash
#FLUX: --job-name=frigid-poodle-8826
#FLUX: --exclusive
#FLUX: -t=600
#FLUX: --priority=16

if command -v sinfo  2>/dev/null # if on cluster
then
    module load mpi/openmpi-x86_64
    module load pmi/pmix-x86_64
    mpiproc=20
else  # if on local machine
    mpiproc=4
fi
mpirun -n $mpiproc ./jacobiMPI 128 1000
