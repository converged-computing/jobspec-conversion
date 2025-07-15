#!/bin/bash
#FLUX: --job-name=misunderstood-lamp-9339
#FLUX: --exclusive
#FLUX: -t=43200
#FLUX: --urgency=16

df /local
LDIR="/local"
source activate dask_distributed
dask-worker --memory-limit 0.08 --nprocs 12 --nthreads 1 --local-directory $LDIR \
       	--scheduler-file $HOME/.dask_schedule_file.json --interface ib0
