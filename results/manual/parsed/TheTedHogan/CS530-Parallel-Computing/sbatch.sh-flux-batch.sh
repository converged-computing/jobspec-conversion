#!/bin/bash
#FLUX: --job-name=hogan
#FLUX: --queue=shortq
#FLUX: -t=120
#FLUX: --urgency=16

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
