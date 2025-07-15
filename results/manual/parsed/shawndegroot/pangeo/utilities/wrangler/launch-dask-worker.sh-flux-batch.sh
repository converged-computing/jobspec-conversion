#!/bin/bash
#FLUX: --job-name=quirky-snack-6965
#FLUX: --priority=16

module purge
source activate pangeo
LDIR=/gpfs/flash/users/$USER
SCHEDULER=$HOME/scheduler.json
dask-worker --memory-limit 0.15 --nthreads 4 --nprocs 6 \
            --local-directory $LDIR \
            --scheduler-file=$SCHEDULER \
            --interface ib0 
