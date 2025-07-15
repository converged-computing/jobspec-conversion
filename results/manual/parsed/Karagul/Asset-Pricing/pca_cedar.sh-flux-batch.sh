#!/bin/bash
#FLUX: --job-name=muffled-avocado-1875
#FLUX: -n=2
#FLUX: -t=10800
#FLUX: --priority=16

module load python27-mpi4py/2.0.0
module load miniconda2
mpirun python pca.py
