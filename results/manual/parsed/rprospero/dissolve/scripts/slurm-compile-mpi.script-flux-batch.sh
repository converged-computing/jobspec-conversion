#!/bin/bash
#FLUX: --job-name=compile-mpi
#FLUX: --queue=scarf
#FLUX: -t=3600
#FLUX: --urgency=16

set -e
BASE_DIR=$(pwd)
echo "Base script dir is ${BASE_DIR}"
ANTLR_VERSION=4.8
ANTLR_JAR=antlr-${ANTLR_VERSION}-complete.jar
if [ -f ${ANTLR_JAR} ]
then
  echo "ANTLR4 JAR file found (${ANTLR_JAR})."
else
  echo "Downloading ANTLR4 JAR (${ANTLR_JAR})..."
  wget https://www.antlr.org/download/${ANTLR_JAR}
fi
ANTLR_ZIP=antlr4-cpp-runtime-${ANTLR_VERSION}-source.zip
if [ -f ${ANTLR_ZIP} ]
then
  echo "ANTLR4 source archive found (${ANTLR_ZIP})."
else
  echo "Downloading ANTLR4 source (${ANTLR_ZIP})..."
  wget https://www.antlr.org/download/${ANTLR_ZIP}
fi
module load foss
module load CMake/3.16.4-GCCcore-9.3.0
BUILD_DIR="${BASE_DIR}/build-$SLURM_JOB_ID"
echo "Build directory is '${BUILD_DIR}'"
mkdir ${BUILD_DIR}
cd ${BUILD_DIR}
conan install ../../ -s compiler.libcxx=libstdc++11 -s compiler.version=9 --build=tbb -o tbb:shared=False
MPI_ROOT=/apps/eb/software/OpenMPI/4.0.3-GCC-9.3.0/bin
cmake ../../ -DMPI_C=${MPI_ROOT}/mpicc -DMPI_CXX=${MPI_ROOT}/mpic++ -DCMAKE_CXX_FLAGS:string="-std=c++17 -pthread" -DCMAKE_C_FLAGS:string="-pthread" -DPARALLEL:bool=true -DBUILD_ANTLR_RUNTIME:bool=true -DANTLR_EXECUTABLE:path=${BASE_DIR}/${ANTLR_JAR} -DBUILD_ANTLR_ZIPFILE:path=${BASE_DIR}/${ANTLR_ZIP}
make -j 8
