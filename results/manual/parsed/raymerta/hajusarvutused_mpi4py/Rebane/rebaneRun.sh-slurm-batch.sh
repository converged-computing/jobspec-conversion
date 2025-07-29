#!/bin/bash
#SBATCH --job-name=Rebane
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1

export MPI4PYDIR='paralleelarvutused'
export PYTHONPATH='$HOME/$MPI4PYDIR/install/lib/python'

module purge
module load openmpi-1.7.3
module load python-2.7.3
export MPI4PYDIR=paralleelarvutused
export PYTHONPATH=$HOME/$MPI4PYDIR/install/lib/python
mpirun python rebane.py
