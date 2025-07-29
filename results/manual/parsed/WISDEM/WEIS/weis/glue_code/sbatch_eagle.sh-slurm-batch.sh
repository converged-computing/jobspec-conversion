#!/bin/bash
#SBATCH --job-name=Design1
#SBATCH --account=allocation_name
#SBATCH --output=Case1.%j.out
#SBATCH --mail-user=user@nrel.gov
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=36

nDV=11  # Number of design variables (x2 for central difference)
nOF=100 # Number of openfast runs per finite-difference evaluation
nC=$(( nDV + nDV * nOF ))   # Number of cores needed. Make sure to request an appropriate number of nodes = N / 36
module purge
module load comp-intel intel-mpi mkl
module unload gcc
source activate weis-env
mpirun -np $nC python runWEIS.py
