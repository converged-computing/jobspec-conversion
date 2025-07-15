#!/bin/bash
#FLUX: --job-name=bumfuzzled-pot-1088
#FLUX: --exclusive
#FLUX: -t=600
#FLUX: --urgency=16

if command -v sinfo  2>/dev/null # if on cluster
then
    module load mpi/openmpi-x86_64
    module load pmi/pmix-x86_64
    mpiproc=20
else  # if on local machine
    mpiproc=4
fi
mpirun -n $mpiproc ./out/build/jacobiMPI_float 2000 10
