#!/bin/bash
#FLUX: --job-name=CUDA_Compile
#FLUX: -n=4
#FLUX: --queue=fwkt_v100
#FLUX: -t=82800
#FLUX: --priority=16

export alpaka_DIR='/home/schenk24/workspace/alpaka/install/'

set -x
export alpaka_DIR=/home/schenk24/workspace/alpaka/install/
module load git gcc cmake cuda boost python
cd ..
mkdir -p build_cuda_1
cd build_cuda_1
cmake .. -DCMAKE_BUILD_TYPE=Release -DALPAKA_ACC_CPU_B_SEQ_T_SEQ_ENABLE=ON -DALPAKA_ACC_GPU_CUDA_ENABLE=ON -DALPAKA_CUDA_ARCH=60 -DBENCHMARKING_ENABLED=ON
cmake --build . --verbose > build_log.txt
cd ..
mkdir -p build_cuda_2
cd build_cuda_2
cmake .. -DCMAKE_BUILD_TYPE=Release -DALPAKA_ACC_CPU_B_SEQ_T_SEQ_ENABLE=ON -DALPAKA_ACC_GPU_CUDA_ENABLE=ON -DALPAKA_CUDA_ARCH=60 -DCMAKE_C_FLAGS_RELEASE="-O3 --use_fast_math" -DBENCHMARKING_ENABLED=ON
cmake --build . --verbose > build_log.txt
cd ..
mkdir -p build_cuda_3
cd build_cuda_3
cmake .. -DCMAKE_BUILD_TYPE=Release -DALPAKA_ACC_CPU_B_SEQ_T_SEQ_ENABLE=ON -DALPAKA_ACC_GPU_CUDA_ENABLE=ON -DALPAKA_CUDA_ARCH=60 -DCMAKE_C_FLAGS_RELEASE="-O3 --use_fast_math" -DBENCHMARKING_ENABLED=ON
cmake --build . --verbose > build_log.txt
cd ..
mkdir -p build_cuda_4
cd build_cuda_4
cmake .. -DCMAKE_BUILD_TYPE=Release -DALPAKA_ACC_CPU_B_SEQ_T_SEQ_ENABLE=ON -DALPAKA_ACC_GPU_CUDA_ENABLE=ON -DALPAKA_CUDA_ARCH=60 -DCMAKE_C_FLAGS_RELEASE="-O3 --use_fast_math" -DBENCHMARKING_ENABLED=ON
cmake --build . --verbose > build_log.txt
cd ..
