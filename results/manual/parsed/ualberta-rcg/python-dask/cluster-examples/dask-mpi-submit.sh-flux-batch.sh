#!/bin/bash
#FLUX: --job-name=dinosaur-carrot-0300
#FLUX: -n=8
#FLUX: -t=900
#FLUX: --urgency=16

source ~/virtualenv/dask/bin/activate
time srun python dask-mpi.py
