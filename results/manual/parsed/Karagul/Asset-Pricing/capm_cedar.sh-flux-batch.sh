#!/bin/bash
#FLUX: --job-name=lovable-car-6235
#FLUX: -n=10
#FLUX: -t=18000
#FLUX: --urgency=16

module load python27-mpi4py/2.0.0
module load miniconda2
mpirun python capm.py
