#!/bin/bash
#FLUX: --job-name=adorable-chair-9610
#FLUX: -c=12
#FLUX: --queue="cscsci"
#FLUX: --priority=16

export PATH='/project/cray/alazzaro/cmake/bin:${PATH}'
export PKG_CONFIG_PATH='${HOME}/libxsmm/lib:${PKG_CONFIG_PATH}'

set -o errexit
set -o pipefail
source /opt/intel/oneapi/mkl/latest/env/vars.sh
module swap PrgEnv-cray PrgEnv-gnu
module load daint-gpu cudatoolkit cdt-cuda
module unload cray-libsci_acc cray-libsci
module list
export PATH=/project/cray/alazzaro/cmake/bin:${PATH}
if [ ! -d "${HOME}/libxsmm" ]; then
  cd "${HOME}"
  git clone https://github.com/libxsmm/libxsmm.git
fi
cd "${HOME}/libxsmm"
git fetch
git checkout a8e43c33533036bb2cca808f246212a601dbae5a
make -j
cd ..
set -o xtrace  # do not set earlier to avoid noise from module
umask 0002  # make sure group members can access the data
mkdir -p "${SCRATCH}/${BUILD_TAG}.ocl"
chmod 0775 "${SCRATCH}/${BUILD_TAG}.ocl"
cd "${SCRATCH}/${BUILD_TAG}.ocl"
export PKG_CONFIG_PATH=${HOME}/libxsmm/lib:${PKG_CONFIG_PATH}
BLAS="-DBLA_VENDOR=Intel10_64lp"
LIBXSMM=libxsmm
cmake \
    -DCMAKE_SYSTEM_NAME=CrayLinuxEnvironment \
    -DCMAKE_CROSSCOMPILING_EMULATOR="" \
    -DUSE_ACCEL=opencl -DWITH_GPU=P100 \
    -DUSE_SMM=${LIBXSMM} ${BLAS} \
    -DOpenCL_LIBRARY="${CUDATOOLKIT_HOME}/lib64/libOpenCL.so" \
    -DMPIEXEC_EXECUTABLE="$(command -v srun)" \
    -DTEST_MPI_RANKS="${SLURM_NTASKS}" \
    -DTEST_OMP_THREADS="${SLURM_CPUS_PER_TASK}" \
    "${WORKSPACE}" |& tee -a "${STAGE_NAME}.out"
make VERBOSE=1 -j |& tee -a "${STAGE_NAME}.out"
