#!/bin/bash
#FLUX: --job-name=butterscotch-eagle-8498
#FLUX: --exclusive
#FLUX: -t=21600
#FLUX: --urgency=16

source mod_env_setup.sh
LDIR=/local/$USER
rm -rf $LDIR
SCHEDULER=$HOME/scheduler.json
mpirun --np 6 dask-mpi --nthreads 4 \
    --memory-limit 0.15 \
    --interface ib0 \
    --no-scheduler --local-directory $LDIR \
    --scheduler-file=$SCHEDULER
