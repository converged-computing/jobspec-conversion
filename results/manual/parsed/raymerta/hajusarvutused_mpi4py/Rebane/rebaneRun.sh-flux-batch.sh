#!/bin/bash
#FLUX: --job-name=Rebane
#FLUX: -n=12
#FLUX: --urgency=16

export MPI4PYDIR='paralleelarvutused'
export PYTHONPATH='$HOME/$MPI4PYDIR/install/lib/python'

module purge
module load openmpi-1.7.3
module load python-2.7.3
export MPI4PYDIR=paralleelarvutused
export PYTHONPATH=$HOME/$MPI4PYDIR/install/lib/python
mpirun python rebane.py
