#!/bin/bash
#FLUX: --job-name=relion_build
#FLUX: -c=8
#FLUX: --gpus-per-task=1
#FLUX: --queue=preempted,gpu
#FLUX: -t=5400
#FLUX: --urgency=16

MY_CUDA_ARCH=(80 86)
MY_BUILD_BASE=$MYDATA/relion_build_v2
mkdir -p $MY_BUILD_BASE
cd $MY_BUILD_BASE
ml purge
ml load ctffind/4.1.14 resmap/1.1.4 cuda/12.2.1_535.86.10 motioncor2/1.6.4 openmpi/4.1.6 cmake/3.28.2
git clone --recursive https://github.com/3dem/relion.git
cd relion
git fetch --all 
git switch ver5.0 
git pull 
for C_ARCH in ${MY_CUDA_ARCH[@]}; 
do
    {
    rm -rf build-gpu_${C_ARCH}
    mkdir -p build-gpu_${C_ARCH}
    pushd build-gpu_${C_ARCH}
    make clean
    cmake -DGUI=OFF -DCUDA=ON -DALTCPU=FALSE -DCudaTexture=ON -DCUDA_ARCH=${C_ARCH} \
    -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DMPI_C_COMPILER=mpicc -DMPI_CXX_COMPILER=mpicc \
    -DDoublePrec_CPU=ON -DDoublePrec_GPU=OFF \
    -DCMAKE_C_FLAGS="-O2 -g -lm" \
    -DCMAKE_CXX_FLAGS="-O2 -g -lm -lstdc++" \
    -DPYTHON_EXE_PATH="/usr/bin/python3.9" \
    -DCMAKE_INSTALL_PREFIX="/hpc/apps/relion/ver5.0-git-CU${C_ARCH}" \
    ..
    make -j 8
    make install 
    popd 
    }
done
exit 0 
    {
    rm -rf build-cpu
    mkdir -p build-cpu
    pushd build-cpu
    cmake -DGUI=OFF -DCUDA=OFF -DALTCPU=TRUE \
    -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DMPI_C_COMPILER=mpicc -DMPI_CXX_COMPILER=mpicc \
    -DDoublePrec_CPU=ON -DDoublePrec_GPU=OFF \
    -DCMAKE_C_FLAGS="-O2 -g -lm" \
    -DCMAKE_CXX_FLAGS="-O2 -g -lm -lstdc++" \
    -DPYTHON_EXE_PATH="/usr/bin/python3.9" \
    -DCMAKE_INSTALL_PREFIX=${MY_BUILD_BASE}/tester-cpu \
    ..
    make -j 8
    make install 
    popd 
    }
