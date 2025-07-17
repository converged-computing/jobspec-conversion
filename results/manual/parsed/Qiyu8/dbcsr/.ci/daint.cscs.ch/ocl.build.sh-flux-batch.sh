#!/bin/bash
#FLUX: --job-name=faux-cherry-9923
#FLUX: -c=12
#FLUX: --queue=cscsci
#FLUX: --urgency=16

export NVSDKCOMPUTE_ROOT='${CUDATOOLKIT_HOME}'
export PKG_CONFIG_PATH='${HOME}/libxsmm/lib:${PKG_CONFIG_PATH}'

set -o errexit
set -o nounset
set -o pipefail
module swap PrgEnv-cray PrgEnv-gnu
module load daint-gpu cudatoolkit cdt-cuda
module load /apps/daint/UES/jenkins/7.0.UP02/gpu/easybuild/modules/all/CMake/3.18.4
module unload cray-libsci_acc
module list
if [ ! -d "${HOME}/libxsmm" ]; then
  cd "${HOME}"
  git clone https://github.com/hfp/libxsmm.git
fi
cd "${HOME}/libxsmm"
git fetch
git checkout 2a373509dadfda2d13f90ae1be920f03d8fb3415
make -j
cd ..
set -o xtrace  # do not set earlier to avoid noise from module
umask 0002  # make sure group members can access the data
mkdir -p "${SCRATCH}/${BUILD_TAG}.ocl"
chmod 0775 "${SCRATCH}/${BUILD_TAG}.ocl"
cd "${SCRATCH}/${BUILD_TAG}.ocl"
export NVSDKCOMPUTE_ROOT=${CUDATOOLKIT_HOME}
export PKG_CONFIG_PATH=${HOME}/libxsmm/lib:${PKG_CONFIG_PATH}
cmake \
    -DCMAKE_SYSTEM_NAME=CrayLinuxEnvironment \
    -DCMAKE_CROSSCOMPILING_EMULATOR="" \
    -DUSE_ACCEL=opencl -DUSE_SMM=libxsmm \
    -DOpenCL_LIBRARY="${CUDATOOLKIT_HOME}/lib64/libOpenCL.so" \
    -DBLAS_FOUND=ON -DBLAS_LIBRARIES="-lsci_gnu_mpi_mp" \
    -DLAPACK_FOUND=ON -DLAPACK_LIBRARIES="-lsci_gnu_mpi_mp" \
    -DMPIEXEC_EXECUTABLE="$(command -v srun)" \
    -DTEST_MPI_RANKS="${SLURM_NTASKS}" \
    -DTEST_OMP_THREADS="${SLURM_CPUS_PER_TASK}" \
    "${WORKSPACE}" |& tee -a "${STAGE_NAME}.out"
make VERBOSE=1 -j |& tee -a "${STAGE_NAME}.out"
