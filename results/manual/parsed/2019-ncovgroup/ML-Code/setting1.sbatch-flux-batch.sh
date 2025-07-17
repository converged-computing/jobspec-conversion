#!/bin/bash
#FLUX: --job-name=anxious-blackbean-2762
#FLUX: -N=4
#FLUX: -c=10
#FLUX: --queue=regular
#FLUX: -t=5400
#FLUX: --urgency=16

DASK=$HOME/scheduler.json
rm -f $DASK
mpirun -np 32 dask-mpi --scheduler-file $DASK --interface 'ib0' --nthreads=10 --memory-limit='15G' --no-nanny --local-directory=/tmp
