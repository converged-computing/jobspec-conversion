#!/bin/bash
#FLUX: --job-name=prefetch
#FLUX: --exclusive
#FLUX: --queue=defq
#FLUX: --priority=16

module purge
module load userspace/custom opt/all userspace/all
module load cmake/3.22.2
module load intel-compiler/64/2018.3.222
module load intel-mkl/64/2018.3.222
module load intel-mpi/64/2018.3.222
module load intel-mpi/64/2018.3.222
make all
