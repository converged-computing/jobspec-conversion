#!/bin/bash
#FLUX: --job-name=adorable-dog-6541
#FLUX: --urgency=16

module load gcc/10.2.0
module load cmake/gcc/3.18.0
module load openmpi/gcc/64/1.10.7
cd build
rm -rf *
cmake ..
make
mpirun ./leibniz 1000
