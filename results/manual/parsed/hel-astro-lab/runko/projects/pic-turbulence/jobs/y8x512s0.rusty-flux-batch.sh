#!/bin/bash
#FLUX: --job-name=reclusive-arm-5746
#FLUX: -N=21
#FLUX: --exclusive
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export PYTHONDONTWRITEBYTECODE='true'
export HDF5_USE_FILE_LOCKING='FALSE'

export OMP_NUM_THREADS=1
export PYTHONDONTWRITEBYTECODE=true
export HDF5_USE_FILE_LOCKING=FALSE
cd $RUNKODIR/projects/pic/
mpirun python3 pic.py --conf y8x512s0.ini
