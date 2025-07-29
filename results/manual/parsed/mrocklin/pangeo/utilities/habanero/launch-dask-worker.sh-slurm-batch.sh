#!/bin/bash
#FLUX: --job-name=dask-worker
#FLUX: --exclusive
#FLUX: -t=21600
#FLUX: --urgency=16

module load anaconda
source activate pangeo
SCHEDULER=$HOME/scheduler.json
mpirun --np 6 dask-mpi --nthreads 4 \
    --memory-limit 12e9 \
    --interface ib0 \
    --no-scheduler --local-directory /local \
    --scheduler-file=$SCHEDULER
