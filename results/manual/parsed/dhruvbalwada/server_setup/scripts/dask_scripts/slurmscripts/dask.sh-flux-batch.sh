#!/bin/bash
#FLUX: --job-name=muffled-house-3726
#FLUX: --exclusive
#FLUX: -t=21600
#FLUX: --urgency=16

export XDG_RUNTIME_DIR=''

DASKDIR=~/.dask_tmp
rm -r $DASKDIR/worker*
source activate standard
export XDG_RUNTIME_DIR=""
rm -f scheduler.json
mpirun --np 4 dask-mpi --nthreads 4 --memory-limit 'auto' --bokeh-port 7771 --interface ib0 --local-directory $DASKDIR
