#!/bin/bash
#FLUX: --job-name=chunky-buttface-5741
#FLUX: --urgency=16

export JUPYTER_RUNTIME_DIR='$WORK'

module purge
source activate pangeo
LDIR=/gpfs/flash/users/$USER
export JUPYTER_RUNTIME_DIR=$WORK
jupyter lab --ip '*' --no-browser --port 8888 \
            --notebook-dir $HOME &
SCHEDULER=$HOME/scheduler.json
rm -f $SCHEDULER
dask-scheduler --scheduler-file $SCHEDULER \
               --local-directory $LDIR &
while [ ! -f $SCHEDULER ]; do 
    sleep 1
done
dask-worker --memory-limit 0.15 --nthreads 4 --nprocs 5 \
            --local-directory $LDIR \
            --scheduler-file=$SCHEDULER \
            --interface ib0 
