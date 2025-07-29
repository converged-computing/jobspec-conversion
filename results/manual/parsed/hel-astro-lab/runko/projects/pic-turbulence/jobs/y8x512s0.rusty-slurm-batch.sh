#!/bin/bash
#FLUX: --job-name=y8x512s0
#FLUX: -N=21
#FLUX: --exclusive
#FLUX: --queue=cca
#FLUX: -t=172800
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export PYTHONDONTWRITEBYTECODE='true'
export HDF5_USE_FILE_LOCKING='FALSE'

export OMP_NUM_THREADS=1
export PYTHONDONTWRITEBYTECODE=true
export HDF5_USE_FILE_LOCKING=FALSE
cd $RUNKODIR/projects/pic/
mpirun python3 pic.py --conf y8x512s0.ini
