#!/bin/bash
#FLUX: --job-name=doopy-lettuce-4269
#FLUX: -N=20
#FLUX: --exclusive
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export PYTHONDONTWRITEBYTECODE='true'
export HDF5_USE_FILE_LOCKING='FALSE'

export OMP_NUM_THREADS=1
export PYTHONDONTWRITEBYTECODE=true
export HDF5_USE_FILE_LOCKING=FALSE
cd $RUNKODIR/projects/shocks/
mpirun python3 pic.py --conf y8x512s0.ini
