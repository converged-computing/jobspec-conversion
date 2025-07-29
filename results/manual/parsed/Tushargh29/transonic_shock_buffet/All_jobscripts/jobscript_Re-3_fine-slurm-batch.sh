#!/bin/bash
#SBATCH --job-name=naca-0012-34
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=5-00:00:00
#SBATCH --constraint=ntasks-per-node=16

module load singularity/3.6.0rc2
module load mpi/openmpi/4.0.1/cuda_aware_gcc_6.3.0
cd run/naca-Re-3-Ma-0.85-fine
./Allrun 16
