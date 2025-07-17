#!/bin/bash
#FLUX: --job-name=dask_launcher
#FLUX: --queue=standard
#FLUX: -t=604800
#FLUX: --urgency=16

export TMPDIR='$PWD/codes_devito'
export OMP_NUM_THREADS='10'
export DEVITO_LANGUAGE='openmp'
export SYMPY_USE_CACHE='no'

export TMPDIR=$PWD/codes_devito
export OMP_NUM_THREADS=10
export DEVITO_LANGUAGE=openmp
export SYMPY_USE_CACHE=no
ulimit -s unlimited
module load gcc/7.3.0
module load anaconda3/2020.02
source activate devito_dask
python RTM_BP_2007_repo.py
