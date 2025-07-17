#!/bin/bash
#FLUX: --job-name=y8x1024s0
#FLUX: -N=20
#FLUX: --exclusive
#FLUX: --queue=cca
#FLUX: -t=604800
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export PYTHONDONTWRITEBYTECODE='true'
export HDF5_USE_FILE_LOCKING='FALSE'

export OMP_NUM_THREADS=1
export PYTHONDONTWRITEBYTECODE=true
export HDF5_USE_FILE_LOCKING=FALSE
cd $RUNKODIR/projects/shocks/
mpirun python3 pic.py --conf y8x1024s0.ini
