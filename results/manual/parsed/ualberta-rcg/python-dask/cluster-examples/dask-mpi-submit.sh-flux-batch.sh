#!/bin/bash
#FLUX: --job-name=chocolate-gato-3815
#FLUX: -t=900
#FLUX: --urgency=16

source ~/virtualenv/dask/bin/activate
time srun python dask-mpi.py
