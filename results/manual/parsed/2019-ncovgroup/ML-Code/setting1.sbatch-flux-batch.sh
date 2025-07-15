#!/bin/bash
#FLUX: --job-name=outstanding-peas-2288
#FLUX: -c=10
#FLUX: --urgency=16

DASK=$HOME/scheduler.json
rm -f $DASK
mpirun -np 32 dask-mpi --scheduler-file $DASK --interface 'ib0' --nthreads=10 --memory-limit='15G' --no-nanny --local-directory=/tmp
