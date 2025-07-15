#!/bin/bash
#FLUX: --job-name=peachy-carrot-5132
#FLUX: --exclusive
#FLUX: -t=43200
#FLUX: --priority=16

df /local
LDIR="/local/dask-worker-dir-$$"
source activate dask_distributed
dask-worker --memory-limit 100e9 --nthreads 4 --local-directory $LDIR \
       	--scheduler-file $HOME/.dask_schedule_file.json --interface ib0
