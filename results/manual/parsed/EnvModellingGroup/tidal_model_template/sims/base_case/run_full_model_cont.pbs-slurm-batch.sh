#!/bin/bash
#FLUX: --job-name=modern_uk
#FLUX: -n=32
#FLUX: -t=14400
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/mnt/scratch/projects/env-tsunami-2019/firedrake_dec23/src/petsc/default/lib/:$LD_LIBRARY_PATH'
export OMP_NUM_THREADS='1'
export OPENBLAS_NUM_THREADS='1'

module load firedrake
unset PYTHONPATH
. /mnt/scratch/projects/env-tsunami-2019/firedrake_dec23/bin/activate
export LD_LIBRARY_PATH=/mnt/scratch/projects/env-tsunami-2019/firedrake_dec23/src/petsc/default/lib/:$LD_LIBRARY_PATH
export OMP_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1
mpiexec -n 32 python tidal_model_cont.py
