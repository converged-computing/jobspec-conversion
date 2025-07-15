#!/bin/bash
#FLUX: --job-name=astute-pedo-4785
#FLUX: -t=900
#FLUX: --priority=16

source ~/virtualenv/dask/bin/activate
time srun python dask-mpi.py
