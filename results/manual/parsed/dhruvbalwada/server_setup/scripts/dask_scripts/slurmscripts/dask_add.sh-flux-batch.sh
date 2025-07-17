#!/bin/bash
#FLUX: --job-name=dask_worker
#FLUX: -N=3
#FLUX: --exclusive
#FLUX: -t=21600
#FLUX: --urgency=16

export XDG_RUNTIME_DIR=''

DASKDIR=~/.dask_tmp
source activate standard
export XDG_RUNTIME_DIR=""
mpirun --n 12 dask-mpi --nthreads 4 --memory-limit 'auto' --interface em1 --no-scheduler --local-directory $DASKDIR
