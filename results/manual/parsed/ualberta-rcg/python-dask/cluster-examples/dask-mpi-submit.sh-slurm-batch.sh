#!/bin/bash
#FLUX: --job-name=conspicuous-toaster-8715
#FLUX: -n=8
#FLUX: -t=900
#FLUX: --urgency=16

source ~/virtualenv/dask/bin/activate
time srun python dask-mpi.py
