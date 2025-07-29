#!/bin/bash
#SBATCH --job-name=dask_launcher
#SBATCH --output=dask_launcher.o%j
#SBATCH --error=dask_launcher.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00

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
