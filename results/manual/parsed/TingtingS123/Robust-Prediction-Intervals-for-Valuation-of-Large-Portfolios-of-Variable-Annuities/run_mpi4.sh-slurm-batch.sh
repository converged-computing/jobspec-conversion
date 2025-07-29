#!/bin/bash
#SBATCH --job-name=bootstrap
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --nodes=4
#SBATCH --ntasks=10
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --partition=research

module purge  # Clears all loaded modules for a clean environment.
module load prun
module load gnu12
module load openmpi4
module load py3-mpi4py  # Python MPI support.
module load py3-numpy  # For numerical computations.
source ~/mypython/mypython/bin/activate  # Activates a Python virtual environment.
module load cmake  # Loads the cmake module for build process management.
mpiexec -n 10 python3 OLS.py  # Executes the Python script in parallel using 10 tasks. The number of bootstrap iterations is 100 for each task. There are 1000 iterations of bootstrap iterations in total.              l
