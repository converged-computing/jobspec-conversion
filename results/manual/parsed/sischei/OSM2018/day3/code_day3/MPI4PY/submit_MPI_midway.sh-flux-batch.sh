#!/bin/bash
#FLUX: --job-name=dinosaur-frito-9074
#FLUX: -N=2
#FLUX: -t=10
#FLUX: --priority=16

module unload openmpi 
module load mpi4py/1.3+python-2.7-2015q2
mpirun python bcast.py
