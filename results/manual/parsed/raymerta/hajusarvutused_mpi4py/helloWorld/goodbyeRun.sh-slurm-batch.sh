#!/bin/bash
#SBATCH --job-name=Goodbye
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --constraint=ntasks-per-node=2

export MPI4PYDIR='paralleelarvutused'
export PYTHONPATH='$HOME/$MPI4PYDIR/install/lib/python'

module purge
module load openmpi-1.7.3
module load python-2.7.3
export MPI4PYDIR=paralleelarvutused
export PYTHONPATH=$HOME/$MPI4PYDIR/install/lib/python
mpirun python helloworld.py
