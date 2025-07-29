#!/bin/bash
#SBATCH --job-name=soma-lulesh
#SBATCH --account=project_2006549
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=medium

set -eu
echo "Setting up spack and modules"
source ./sourceme.sh
echo "Starting LULESH + SOMA"
cp ../lulesh2.0 .
srun -n 1 -N 1 ./lulesh2.0 -i 50 -p
