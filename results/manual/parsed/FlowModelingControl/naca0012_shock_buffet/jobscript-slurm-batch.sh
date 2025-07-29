#!/bin/bash
#SBATCH --job-name=na12
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=5-00:00:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=8

module load singularity/3.6.0rc2
module load mpi/openmpi/4.0.1/cuda_aware_gcc_6.3.0
echo "Submitting case $1"
cd run/$1
./Allrun
