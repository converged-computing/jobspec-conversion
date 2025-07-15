#!/bin/bash
#FLUX: --job-name=red-bicycle-9108
#FLUX: -n=4
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module load mpi4py
module load python/3.6
srun --mpi=pmix mandelbrot_mpi.py
