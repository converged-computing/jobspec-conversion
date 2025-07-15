#!/bin/bash
#FLUX: --job-name=cudaopenmpbuild
#FLUX: --queue=gpu
#FLUX: -t=300
#FLUX: --priority=16

module load gcc/11.2.0-gcc-11.2.0
module load nvhpc/23.9-gcc-11.2.0
spack load cmake@3.23.1%gcc
gxx="/sw/spack-levante/gcc-11.2.0-bcn7mb/bin/g++"
gcc="/sw/spack-levante/gcc-11.2.0-bcn7mb/bin/gcc"
path2CLEO=$1    # get from command line argument
path2build=$2   # get from command line argument
CC=${gcc}               # C
CXX=${gxx}              # C++
CMAKE_CXX_FLAGS="-Werror -Wall -pedantic -O3"                            # performance
CUDA_ROOT="/sw/spack-levante/nvhpc-23.9-xpxqeo/Linux_x86_64/23.9/cuda/"
NVCC_WRAPPER_DEFAULT_COMPILER=${gxx}
kokkosflags="-DKokkos_ARCH_NATIVE=ON -DKokkos_ARCH_AMPERE80=ON -DKokkos_ENABLE_SERIAL=ON"
kokkoshost="-DKokkos_ENABLE_OPENMP=ON"
kokkosdevice="-DKokkos_ENABLE_CUDA=ON -DKokkos_ENABLE_CUDA_LAMBDA=ON \
-DKokkos_ENABLE_CUDA_CONSTEXPR=ON -DKokkos_ENABLE_CUDA_RELOCATABLE_DEVICE_CODE=ON \
-DCUDA_ROOT=${CUDA_ROOT} -DNVCC_WRAPPER_DEFAULT_COMPILER=${CXX}"
echo "CXX_COMPILER=${CXX} CC_COMPILER=${CC}"
echo "CUDA=${CUDA_ROOT}/bin/nvcc (via Kokkos nvcc wrapper)"
echo "NVCC_WRAPPER_DEFAULT_COMPILER=${NVCC_WRAPPER_DEFAULT_COMPILER}"
echo "CLEO_DIR: ${path2CLEO}"
echo "BUILD_DIR: ${path2build}"
echo "KOKKOS_FLAGS: ${kokkosflags}"
echo "KOKKOS_DEVICE_PARALLELISM: ${kokkosdevice}"
echo "KOKKOS_HOST_PARALLELISM: ${kokkoshost}"
echo "CMAKE_CXX_FLAGS: ${CMAKE_CXX_FLAGS}"
cmake -DCMAKE_CXX_COMPILER=${CXX} \
    -DCMAKE_CC_COMPILER=${CC} \
    -DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS}" \
    -S ${path2CLEO} -B ${path2build} \
    ${kokkosflags} ${kokkosdevice} ${kokkoshost}
mkdir -p ${path2build}/bin
mkdir -p ${path2build}/share
