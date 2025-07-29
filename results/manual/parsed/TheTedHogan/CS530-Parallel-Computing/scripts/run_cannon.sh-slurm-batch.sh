#!/bin/bash
#FLUX: --job-name=hogan
#FLUX: -n=9
#FLUX: --queue=defq
#FLUX: -t=120
#FLUX: --urgency=16

module load gcc/10.2.0
module load cmake/gcc/3.18.0
module load openmpi/gcc/64/1.10.7
cd build
rm -rf *
cmake ..
make
mpirun ./matrixmatrixcannon  12  ../out/cannon_out.mtx
