#!/bin/bash
#SBATCH --job-name=hogan
#SBATCH --output=./out/output.o%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:02:00

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module load gcc/10.2.0
module load cmake/gcc/3.18.0
rm -rf build
mkdir build
cd build
cmake ..
make
mpirun -np 4 ./matrixmatrix ../etc/2by3matrix.mtx ../etc/3by2matrix.mtx ../etc/r2testoutmm.mtx
