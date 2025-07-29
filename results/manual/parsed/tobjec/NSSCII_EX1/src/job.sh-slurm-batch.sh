#!/bin/bash
#SBATCH --job-name=cpu01
#SBATCH --output=stdout-%x.%j.log
#SBATCH --error=stderr-%x.%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

module load pmi/pmix-x86_64     # [P]rocess [M]anagement [I]nterface (required by MPI-Implementation)
module load mpi/openmpi-x86_64  # MPI implementation (including compiler-wrappers mpicc/mpic++)
mpic++ -std=c++20 -O3 -pedantic -march=native -ffast-math impl_1d.cpp -o impl_1d
mpi_mode=1D
filename=cpu01
resolutions=(125 250 1000 2000)
iterations=800
for resolution in "${resolutions[@]}"
do
  srun --mpi=pmix ./impl_1d ${mpi_mode} ${filename}_res${resolution} ${resolution} ${iterations} -100 +100
done
