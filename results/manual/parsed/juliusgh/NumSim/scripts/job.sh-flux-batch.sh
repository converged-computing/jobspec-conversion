#!/bin/bash
#FLUX: --job-name=submission
#FLUX: -n=16
#FLUX: -t=600
#FLUX: --priority=16

export CPATH='/scratch-nfs/maierbn/openmpi/install-3.1/include'
export PATH='/scratch-nfs/maierbn/openmpi/install-3.1/bin:$PATH'

module use /usr/local.nfs/sgs/modulefiles
module load gcc/10.2
module load openmpi/3.1.6-gcc-10.2
module load vtk/9.0.1
module load cmake/3.18.2
rm -rf build
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j
cd ..
export CPATH=/scratch-nfs/maierbn/openmpi/install-3.1/include
export PATH=/scratch-nfs/maierbn/openmpi/install-3.1/bin:$PATH
srun -n $1 ./build/src/numsim_parallel parameters/$2
