#!/bin/bash
#FLUX: --job-name=dask-worker
#FLUX: -n=6
#FLUX: --queue=normal
#FLUX: -t=7200
#FLUX: --urgency=16

module purge
source activate pangeo
LDIR=/gpfs/flash/users/$USER
SCHEDULER=$HOME/scheduler.json
dask-worker --memory-limit 0.15 --nthreads 4 --nprocs 6 \
            --local-directory $LDIR \
            --scheduler-file=$SCHEDULER \
            --interface ib0 
