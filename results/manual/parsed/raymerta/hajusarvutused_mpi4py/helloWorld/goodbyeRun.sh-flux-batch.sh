#!/bin/bash
#FLUX: --job-name=astute-leopard-4292
#FLUX: --priority=16

export MPI4PYDIR='paralleelarvutused'
export PYTHONPATH='$HOME/$MPI4PYDIR/install/lib/python'

module purge
module load openmpi-1.7.3
module load python-2.7.3
export MPI4PYDIR=paralleelarvutused
export PYTHONPATH=$HOME/$MPI4PYDIR/install/lib/python
mpirun python helloworld.py
