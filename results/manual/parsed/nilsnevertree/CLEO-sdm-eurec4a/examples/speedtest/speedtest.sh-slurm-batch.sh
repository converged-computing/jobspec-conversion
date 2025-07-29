#!/bin/bash
#FLUX: --job-name=speedtest
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'

module load gcc/11.2.0-gcc-11.2.0
module load python3/2022.01-gcc-11.2.0
module load nvhpc/23.9-gcc-11.2.0
spack load cmake@3.23.1%gcc
source activate /work/mh1126/m300950/condaenvs/superdropsenv
path2CLEO=${HOME}/CLEO/
path2build=${HOME}/CLEO/build5/
configfile=${path2CLEO}/examples/speedtest/src/config/speedtest_config.txt
python=/work/mh1126/m300950/condaenvs/superdropsenv/bin/python
gxx="/sw/spack-levante/gcc-11.2.0-bcn7mb/bin/g++"
gcc="/sw/spack-levante/gcc-11.2.0-bcn7mb/bin/gcc"
CC=${gcc}               # C
CXX=${gxx}              # C++
CMAKE_CXX_FLAGS="-Werror -Wall -pedantic -O3"                            # performance
CUDA_ROOT="/sw/spack-levante/nvhpc-23.9-xpxqeo/Linux_x86_64/23.9/cuda/"
NVCC_WRAPPER_DEFAULT_COMPILER=${gxx}
kokkosflags="-DKokkos_ARCH_NATIVE=ON -DKokkos_ARCH_AMPERE80=ON -DKokkos_ENABLE_SERIAL=ON"
use_kokkoshost="-DKokkos_ENABLE_OPENMP=ON"
use_kokkosdevice="-DKokkos_ENABLE_CUDA=ON -DKokkos_ENABLE_CUDA_LAMBDA=ON \
-DKokkos_ENABLE_CUDA_CONSTEXPR=ON -DKokkos_ENABLE_CUDA_RELOCATABLE_DEVICE_CODE=ON \
-DCUDA_ROOT=${CUDA_ROOT} -DNVCC_WRAPPER_DEFAULT_COMPILER=${CXX}"
echo "CXX_COMPILER=${CXX} CC_COMPILER=${CC}"
echo "CUDA=${CUDA_ROOT}/bin/nvcc (via Kokkos nvcc wrapper)"
echo "NVCC_WRAPPER_DEFAULT_COMPILER=${NVCC_WRAPPER_DEFAULT_COMPILER}"
echo "CLEO_DIR: ${path2CLEO}"
echo "CMAKE_CXX_FLAGS: ${CMAKE_CXX_FLAGS}"
mkdir ${path2build}/bin
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
buildtype="gpus_cpus"
kokkoshost=${use_kokkoshost}
kokkosdevice=${use_kokkosdevice}
path2build_gpus_cpus=${path2build}${buildtype}"/"
echo "build type: ${buildtype}"
echo "KOKKOS_FLAGS: ${kokkosflags}"
echo "KOKKOS_DEVICE_PARALLELISM: ${kokkosdevice}"
echo "KOKKOS_HOST_PARALLELISM: ${kokkoshost}"
echo "BUILD_DIR: ${path2build_gpus_cpus}"
cmake -DCMAKE_CXX_COMPILER=${CXX} \
    -DCMAKE_CC_COMPILER=${CC} \
    -DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS}" \
    -S ${path2CLEO} -B ${path2build_gpus_cpus} \
    ${kokkosflags} ${kokkosdevice} ${kokkoshost}
make clean -C ${path2build_gpus_cpus}
make -C ${path2build_gpus_cpus} -j 64 spdtest
mkdir ${path2build_gpus_cpus}/bin
mkdir ${path2build_gpus_cpus}/share
${python} ${path2CLEO}/examples/speedtest/speedtest.py \
  ${path2CLEO} ${path2build_gpus_cpus} ${configfile} ${path2build}"/bin/" ${buildtype}
buildtype="cpus"
kokkoshost=${use_kokkoshost}
kokkosdevice=""
path2build_cpus=${path2build}${buildtype}"/"
echo "build type: ${buildtype}"
echo "KOKKOS_FLAGS: ${kokkosflags}"
echo "KOKKOS_DEVICE_PARALLELISM: ${kokkosdevice}"
echo "KOKKOS_HOST_PARALLELISM: ${kokkoshost}"
echo "BUILD_DIR: ${path2build_cpus}"
cmake -DCMAKE_CXX_COMPILER=${CXX} \
    -DCMAKE_CC_COMPILER=${CC} \
    -DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS}" \
    -S ${path2CLEO} -B ${path2build_cpus} \
    ${kokkosflags} ${kokkosdevice} ${kokkoshost}
make clean -C ${path2build_cpus}
make -C ${path2build_cpus} -j 64 spdtest
mkdir ${path2build_cpus}/bin
mkdir ${path2build_cpus}/share
${python} ${path2CLEO}/examples/speedtest/speedtest.py \
  ${path2CLEO} ${path2build_cpus} ${configfile} ${path2build}"/bin/" ${buildtype}
buildtype="serial"
kokkoshost=""
kokkosdevice=""
path2build_serial=${path2build}${buildtype}"/"
echo "build type: ${buildtype}"
echo "KOKKOS_FLAGS: ${kokkosflags}"
echo "KOKKOS_DEVICE_PARALLELISM: ${kokkosdevice}"
echo "KOKKOS_HOST_PARALLELISM: ${kokkoshost}"
echo "BUILD_DIR: ${path2build_serial}"
cmake -DCMAKE_CXX_COMPILER=${CXX} \
    -DCMAKE_CC_COMPILER=${CC} \
    -DCMAKE_CXX_FLAGS="${CMAKE_CXX_FLAGS}" \
    -S ${path2CLEO} -B ${path2build_serial} \
    ${kokkosflags} ${kokkosdevice} ${kokkoshost}
make clean -C ${path2build_serial}
make -C ${path2build_serial} -j 64 spdtest
mkdir ${path2build_serial}/bin
mkdir ${path2build_serial}/share
${python} ${path2CLEO}/examples/speedtest/speedtest.py \
  ${path2CLEO} ${path2build_serial} ${configfile} ${path2build}"/bin/" ${buildtype}
