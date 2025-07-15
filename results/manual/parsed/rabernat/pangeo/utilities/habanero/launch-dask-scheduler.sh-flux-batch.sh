#!/bin/bash
#FLUX: --job-name=eccentric-cattywampus-1569
#FLUX: --exclusive
#FLUX: -t=21600
#FLUX: --priority=16

module load anaconda
source activate pangeo
LDIR=/local/$USER
rm -rf $LDIR
SCHEDULER=$HOME/scheduler.json
rm -f $SCHEDULER
mpirun --np 6 dask-mpi --nthreads 4 \
    --memory-limit 0.15 \
    --local-directory $LDIR \
    --scheduler-file=$SCHEDULER
    # this makes the bokeh not work
    #--interface ib0 \
