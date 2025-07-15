#!/bin/bash
#FLUX: --job-name=Design1
#FLUX: -N=4
#FLUX: -t=3600
#FLUX: --priority=16

nDV=11  # Number of design variables (x2 for central difference)
nOF=100 # Number of openfast runs per finite-difference evaluation
nC=$(( nDV + nDV * nOF ))   # Number of cores needed. Make sure to request an appropriate number of nodes = N / 36
module purge
module load comp-intel intel-mpi mkl
module unload gcc
source activate weis-env
mpirun -np $nC python runWEIS.py
