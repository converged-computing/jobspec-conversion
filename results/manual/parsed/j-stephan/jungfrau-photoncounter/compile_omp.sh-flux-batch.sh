#!/bin/bash
#FLUX: --job-name=OpenMP_Compile
#FLUX: -n=4
#FLUX: --queue=defq
#FLUX: -t=3600
#FLUX: --priority=16

export alpaka_DIR='/home/schenk24/workspace/alpaka/install/'

set -x
export alpaka_DIR=/home/schenk24/workspace/alpaka/install/
module load git intel cmake boost python
mkdir -p build_omp
cd build_omp
cmake .. -DCMAKE_BUILD_TYPE=Release -DBENCHMARKING_ENABLED=ON -DALPAKA_ACC_GPU_CUDA_ENABLE=OFF -DCMAKE_C_FLAGS_RELEASE="-O3 -march=native -DNDEBUG" -DCMAKE_CXX_FLAGS_RELEASE="-O3 -march=native -DNDEBUG"
make -j
