#!/bin/bash
#FLUX: --job-name=sticky-bits-7854
#FLUX: -n=48
#FLUX: -t=3600
#FLUX: --priority=16

module load scitools
HOST=${1}
PORT=${2}
NWORKERS=48
dask-worker --nprocs ${NWORKERS} --nthreads 1 "${HOST}:${PORT}"
