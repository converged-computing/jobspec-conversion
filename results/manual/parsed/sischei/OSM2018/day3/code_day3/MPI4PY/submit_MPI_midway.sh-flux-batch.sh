#!/bin/bash
#FLUX: --job-name=ornery-cherry-6649
#FLUX: -N=2
#FLUX: -t=10
#FLUX: --urgency=16

module unload openmpi 
module load mpi4py/1.3+python-2.7-2015q2
mpirun python bcast.py
