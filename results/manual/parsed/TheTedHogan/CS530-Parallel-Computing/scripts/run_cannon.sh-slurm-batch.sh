#!/bin/bash
#SBATCH --job-name=hogan
#SBATCH --output=./output/cannon_output.o
#SBATCH --nodes=1
#SBATCH --ntasks=9
#SBATCH --cpus-per-task=1
#SBATCH --time=00:02:00

module load gcc/10.2.0
module load cmake/gcc/3.18.0
module load openmpi/gcc/64/1.10.7
cd build
rm -rf *
cmake ..
make
mpirun ./matrixmatrixcannon  12  ../out/cannon_out.mtx
