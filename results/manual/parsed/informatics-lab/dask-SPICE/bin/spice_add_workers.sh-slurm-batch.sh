#!/bin/bash
#FLUX: --job-name=joyous-spoon-0728
#FLUX: -n=48
#FLUX: -t=3600
#FLUX: --urgency=16

module load scitools
HOST=${1}
PORT=${2}
NWORKERS=48
dask-worker --nprocs ${NWORKERS} --nthreads 1 "${HOST}:${PORT}"
