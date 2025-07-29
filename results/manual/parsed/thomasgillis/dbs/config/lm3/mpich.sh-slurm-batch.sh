#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=batch

echo "loading modules"
module purge
module load releases/2021b
module load GCC/11.2.0
module load Automake Autoconf libtool CMake
module list
CLUSTER=lm3/mpich make info
CLUSTER=lm3/mpich make install
