#!/bin/bash
#FLUX: --job-name=eccentric-sundae-1625
#FLUX: -n=2
#FLUX: -t=10800
#FLUX: --urgency=16

module load python27-mpi4py/2.0.0
module load miniconda2
mpirun python pca.py
