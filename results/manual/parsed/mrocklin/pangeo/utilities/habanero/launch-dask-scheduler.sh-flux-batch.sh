#!/bin/bash
#FLUX: --job-name=crunchy-train-4499
#FLUX: --exclusive
#FLUX: -t=21600
#FLUX: --urgency=16

module load anaconda
source activate pangeo
SCHEDULER=$HOME/scheduler.json
rm -f $SCHEDULER
mpirun --np 6 dask-mpi --nthreads 4 \
    --memory-limit 12e9 \
    --local-directory /local \
    --scheduler-file=$SCHEDULER
    # this makes the bokeh not work
    #--interface ib0 \
