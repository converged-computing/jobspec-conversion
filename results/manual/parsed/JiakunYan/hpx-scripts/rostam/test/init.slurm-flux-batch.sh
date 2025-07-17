#!/bin/bash
#FLUX: --job-name=hpx-init
#FLUX: --queue=jenkins-compute
#FLUX: -t=7200
#FLUX: --urgency=16

export CC='gcc'
export CXX='g++'

set -e
source ../../include/scripts.sh
HPX_SOURCE_PATH=$(realpath "${HPX_SOURCE_PATH:-../../../hpx-lci-pool}")
LCI_SOURCE_PATH=$(realpath "${LCI_SOURCE_PATH:-../../../LC-tag}")
if [[ -f "${HPX_SOURCE_PATH}/libs/full/include/include/hpx/hpx.hpp" ]]; then
  echo "Found HPX at ${HPX_SOURCE_PATH}"
else
  echo "Did not find HPX at ${HPX_SOURCE_PATH}!"
  exit 1
fi
mkdir -p ./init
cd init
module purge
module load gcc
module load cmake
module load boost/1.80.0-debug
module load hwloc
module load openmpi
module load papi
export CC=gcc
export CXX=g++
record_env
mkdir -p log
mv *.log log
mkdir -p build
cd build
echo "Running cmake..."
HPX_INSTALL_PATH=$(realpath "../install")
cmake -GNinja \
      -DCMAKE_INSTALL_PREFIX=${HPX_INSTALL_PATH} \
      -DHPX_WITH_PARALLEL_TESTS_BIND_NONE=ON \
      -DCMAKE_BUILD_TYPE=Debug \
      -DHPX_WITH_CHECK_MODULE_DEPENDENCIES=ON \
      -DHPX_WITH_CXX_STANDARD=20 \
      -DHPX_WITH_DATAPAR_BACKEND=STD_EXPERIMENTAL_SIMD \
      -DHPX_WITH_MALLOC=system \
      -DHPX_WITH_FETCH_ASIO=ON \
      -DHPX_WITH_COMPILER_WARNINGS=ON \
      -DHPX_WITH_COMPILER_WARNINGS_AS_ERRORS=ON \
      -DHPX_WITH_PARCELPORT_MPI=ON \
      -DHPX_WITH_PARCELPORT_LCI=ON \
      -DHPX_WITH_FETCH_LCI=ON \
      -DFETCHCONTENT_SOURCE_DIR_LCI=${LCI_SOURCE_PATH} \
      -DLCI_DEBUG=ON \
      -DHPX_WITH_PARCELPORT_LCI_BACKEND=ibv \
      -DHPX_WITH_PARCELPORT_COUNTERS=ON \
      -L \
      ${HPX_SOURCE_PATH} | tee init-cmake.log 2>&1 || { echo "cmake error!"; exit 1; }
cmake -LAH . >> init-cmake.log
echo "Running make..."
ninja hello_world_distributed | tee init-make.log 2>&1 || { echo "make error!"; exit 1; }
