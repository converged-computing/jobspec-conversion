#!/bin/bash
#FLUX: --job-name=bloated-buttface-1123
#FLUX: -n=48
#FLUX: -t=3600
#FLUX: --urgency=16

module load scitools
HOST=${1}
PORT=${2}
NWORKERS=48
dask-worker --nprocs ${NWORKERS} --nthreads 1 "${HOST}:${PORT}"
