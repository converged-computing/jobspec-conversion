#!/bin/bash
#FLUX: --job-name=vasc_build_mpich
#FLUX: --queue=gpu
#FLUX: -t=18000
#FLUX: --urgency=16

module unload mvapich2/2.3.3/intel-19.0.5
module load cmake git hwloc parallel gcc mpich
BUILD_TYPE=Release
BASE_DIR=$(pwd)
SPACK_DIR=${BASE_DIR}/spack
VASC_DIR=${BASE_DIR}/VascularModeling
mkdir -p ${BASE_DIR}
if [ ! -d ${VASC_DIR} ]; then
  git clone git@github.com:STEllAR-GROUP/VascularModeling.git ${VASC_DIR}
  cd ${VASC_DIR}
  git checkout modern-mpi
  cd ${BASE_DIR}
fi
if [ ! -d ${SPACK_DIR} ]; then
  git clone https://github.com/spack/spack.git ${SPACK_DIR}
fi
if [ "${SPACK_ENV}" ]; then
  despacktivate
fi
if [ -z "${SPACK_ROOT}" ]; then
  source ${SPACK_DIR}/share/spack/setup-env.sh
fi
if [ ! -d ${BASE_DIR}/.spack-env ]; then
  spack env create -d ${BASE_DIR}
  spack env activate -p ${BASE_DIR}
  sed -i 's/unify: false/unify: true/' ${BASE_DIR}/spack.yaml
  spack compiler find
  spack external find cmake hwloc mpich
  spack add fzf neovim hdf5^mpich parmetis^mpich metis googletest sleef hypre^mpich clhep intel-mkl
  spack concretize
  spack install
fi
spack env activate -p ${BASE_DIR}
METIS_DIR=$(spack find -p metis | egrep "/work.*" -o  | sed -n '2 p')
HYPRE_DIR=$(spack find -p hypre | egrep "/work.*" -o  | sed -n '2 p')
sleef_DIR=$(spack find -p sleef | egrep "/work.*" -o  | sed -n '2 p')
CPATH=$CPATH:$METIS_DIR/include
cd ${VASC_DIR}
cmake                                        \
  -DHYPRE_LIBRARY=$HYPRE_DIR/lib/libHYPRE.so \
  -Dsleef_DIRECTORY=$sleef_DIR               \
  -DCMAKE_CXX_FLAGS=-march=native            \
  -DCMAKE_BUILD_TYPE=$BUILD_TYPE             \
  -DCMAKE_C_COMPILER=mpicc                   \
  -DCMAKE_CXX_COMPILER=mpic++                \
  -S ${VASC_DIR} -B ${VASC_DIR}/cmake-build/$BUILD_TYPE
cmake --build ${VASC_DIR}/cmake-build/$BUILD_TYPE --parallel
