#!/bin/bash
#FLUX: --job-name=serialbuild
#FLUX: --queue=compute
#FLUX: -t=300
#FLUX: --urgency=16

module load gcc/11.2.0-gcc-11.2.0
spack load cmake@3.23.1%gcc
gxx="/sw/spack-levante/gcc-11.2.0-bcn7mb/bin/g++"
gcc="/sw/spack-levante/gcc-11.2.0-bcn7mb/bin/gcc"
path2CLEO=$1    # get from command line argument
path2build=$2   # get from command line argument
CC=${gcc}               # C
CXX=${gxx}              # C++
CMAKE_CXX_FLAGS="-Werror -Wall -pedantic -O3"                            # performance
kokkosflags="-DKokkos_ARCH_NATIVE=ON -DKokkos_ENABLE_SERIAL=ON" # serial kokkos
kokkoshost=""
kokkosdevice=""
echo "CXX_COMPILER=${CXX} CC_COMPILER=${CC}"
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
