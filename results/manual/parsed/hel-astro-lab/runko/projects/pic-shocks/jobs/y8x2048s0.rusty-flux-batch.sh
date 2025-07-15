#!/bin/bash
#FLUX: --job-name=crunchy-puppy-9511
#FLUX: -N=20
#FLUX: --exclusive
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export PYTHONDONTWRITEBYTECODE='true'
export HDF5_USE_FILE_LOCKING='FALSE'

export OMP_NUM_THREADS=1
export PYTHONDONTWRITEBYTECODE=true
export HDF5_USE_FILE_LOCKING=FALSE
cd $RUNKODIR/projects/shocks/
mpirun python3 pic.py --conf y8x2048s0.ini
