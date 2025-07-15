#!/bin/bash
#FLUX: --job-name=divfree2d
#FLUX: --queue=gpu
#FLUX: -t=600
#FLUX: --priority=16

export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'

module load gcc/11.2.0-gcc-11.2.0
module load python3/2022.01-gcc-11.2.0
module load nvhpc/23.9-gcc-11.2.0
spack load cmake@3.23.1%gcc
source activate /work/mh1126/m300950/condaenvs/superdropsenv
path2CLEO=${HOME}/CLEO/
path2build=${HOME}/CLEO/build3/
configfile=${path2CLEO}/examples/divfreemotion/src/config/divfree2d_config.txt
python=/work/mh1126/m300950/condaenvs/superdropsenv/bin/python
gxx="/sw/spack-levante/gcc-11.2.0-bcn7mb/bin/g++"
gcc="/sw/spack-levante/gcc-11.2.0-bcn7mb/bin/gcc"
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
make clean -C ${path2build}
make -C ${path2build} -j 64 divfree2D
mkdir ${path2build}bin
mkdir ${path2build}share
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
${python} ${path2CLEO}/examples/divfreemotion/divfree2d.py \
  ${path2CLEO} ${path2build} ${configfile}
