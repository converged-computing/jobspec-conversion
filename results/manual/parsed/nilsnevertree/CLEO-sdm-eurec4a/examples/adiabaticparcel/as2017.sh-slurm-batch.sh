#!/bin/bash
#FLUX: --job-name=as2017
#FLUX: --queue=compute
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'

module load gcc/11.2.0-gcc-11.2.0
module load python3/2022.01-gcc-11.2.0
spack load cmake@3.23.1%gcc
source activate /work/mh1126/m300950/condaenvs/superdropsenv
path2CLEO=${HOME}/CLEO/
path2build=${HOME}/CLEO/build0/
configfile=${path2CLEO}/examples/adiabaticparcel/src/config/as2017_config.txt
python=/work/mh1126/m300950/condaenvs/superdropsenv/bin/python
gxx="/sw/spack-levante/gcc-11.2.0-bcn7mb/bin/g++"
gcc="/sw/spack-levante/gcc-11.2.0-bcn7mb/bin/gcc"
CC=${gcc}               # C
CXX=${gxx}              # C++
CMAKE_CXX_FLAGS="-Werror -Wall -pedantic -O3"                            # performance
kokkosflags="-DKokkos_ARCH_NATIVE=ON -DKokkos_ARCH_AMPERE80=ON -DKokkos_ENABLE_SERIAL=ON"
kokkoshost="-DKokkos_ENABLE_OPENMP=ON"
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
make clean -C ${path2build}
make -C ${path2build} -j 64 adia0D
mkdir ${path2build}bin
mkdir ${path2build}share
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
${python} ${path2CLEO}/examples/adiabaticparcel/as2017.py \
  ${path2CLEO} ${path2build} ${configfile}
