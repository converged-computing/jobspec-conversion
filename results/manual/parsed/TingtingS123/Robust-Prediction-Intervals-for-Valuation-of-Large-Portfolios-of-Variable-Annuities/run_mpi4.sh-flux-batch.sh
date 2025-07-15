#!/bin/bash
#FLUX: --job-name=bootstrap
#FLUX: -N=4
#FLUX: -n=10
#FLUX: --queue=research
#FLUX: -t=43200
#FLUX: --urgency=16

module purge  # Clears all loaded modules for a clean environment.
module load prun
module load gnu12
module load openmpi4
module load py3-mpi4py  # Python MPI support.
module load py3-numpy  # For numerical computations.
source ~/mypython/mypython/bin/activate  # Activates a Python virtual environment.
module load cmake  # Loads the cmake module for build process management.
mpiexec -n 10 python3 OLS.py  # Executes the Python script in parallel using 10 tasks. The number of bootstrap iterations is 100 for each task. There are 1000 iterations of bootstrap iterations in total.              l
