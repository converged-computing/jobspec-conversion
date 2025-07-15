#!/bin/bash
#FLUX: --job-name=IPC_build
#FLUX: -c=16
#FLUX: -t=1800
#FLUX: --priority=16

if type "module" > /dev/null 2>&1; then
    # Load modules
    module purge
    module load cgal/intel/4.10b1
    module swap boost/intel/1.62.0 boost/intel/1.71.0
    module load suitesparse/intel/4.5.4 swig/gnu/3.0.11 ilmbase/intel/2.2.0 \
    openexr/intel/2.2.0 openmpi/intel/3.1.4 fftw/intel/3.3.6-pl2 \
    glew/intel/2.1.0 lapack/gnu/3.7.0
    module swap gcc gcc/9.1.0
    module load cmake/intel/3.11.4 mosek/8.1.0.64 tbb/intel/2017u3
    module load gurobi/9.0.0
    module load gmp/gnu/6.1.2
    export CC=${GCC_ROOT}/bin/gcc
    export CXX=${GCC_ROOT}/bin/g++
    export CX=$CXX
fi
if [ -z "${SLURM_SUBMIT_DIR}" ]; then
    cd "${SLURM_SUBMIT_DIR}"
fi
mkdir -p build
cd build
if [ -z "${BUILD_TYPE}" ]; then
    BUILD_TYPE=Release
fi
echo ${BUILD_TYPE}
cmake -DMAKE_BUILD_TYPE=${BUILD_TYPE} ..
make -j16
