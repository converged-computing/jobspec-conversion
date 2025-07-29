#!/bin/bash
#SBATCH --job-name=hpx-test
#SBATCH --output=slurm_output.%x-o%j
#SBATCH --error=slurm_error.%x-o%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --partition=jenkins-compute
#SBATCH --constraint=ntasks-per-node=16

export CC='gcc'
export CXX='g++'

module purge
module load gcc
module load cmake
module load boost
module load hwloc
module load openmpi
module load papi
module load python
export CC=gcc
export CXX=g++
PATH_TO_EXE=${1:-./init/build/}
cd ${PATH_TO_EXE}
time ninja tests
time ctest --verbose --timeout 300
