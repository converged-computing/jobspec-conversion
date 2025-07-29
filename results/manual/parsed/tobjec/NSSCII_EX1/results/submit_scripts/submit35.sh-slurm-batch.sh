#!/bin/bash
#SBATCH --job-name=cpu35
#SBATCH --output=stdout-%x.%j.log
#SBATCH --error=stderr-%x.%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=35
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=nssc

module load pmi/pmix-x86_64     # [P]rocess [M]anagement [I]nterface (required by MPI-Implementation)
module load mpi/openmpi-x86_64  # MPI implementation (including compiler-wrappers mpicc/mpic++)
mpic++ -std=c++17 -O3 -pedantic -march=native -ffast-math impl_1d.cpp -o impl_1d
mpi_mode=1D
filename=cpu35
resolutions=(125 250 1000 2000)
iterations=800
for resolution in "${resolutions[@]}"
do
  mpirun ./impl_1d ${mpi_mode} ${filename}_res${resolution} ${resolution} ${iterations} -100 +100
done
