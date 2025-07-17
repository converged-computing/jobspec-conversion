#!/bin/bash
#FLUX: --job-name=mandelbrot
#FLUX: -n=4
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module load mpi4py
module load python/3.6
srun --mpi=pmix mandelbrot_mpi.py
