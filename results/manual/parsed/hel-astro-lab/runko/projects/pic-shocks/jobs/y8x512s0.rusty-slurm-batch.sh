#!/bin/bash
#SBATCH --job-name=y8x512s0
#SBATCH --output=%J.out
#SBATCH --error=%J.err
#SBATCH --nodes=20
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=40,skylake

export OMP_NUM_THREADS='1'
export PYTHONDONTWRITEBYTECODE='true'
export HDF5_USE_FILE_LOCKING='FALSE'

export OMP_NUM_THREADS=1
export PYTHONDONTWRITEBYTECODE=true
export HDF5_USE_FILE_LOCKING=FALSE
cd $RUNKODIR/projects/shocks/
mpirun python3 pic.py --conf y8x512s0.ini
