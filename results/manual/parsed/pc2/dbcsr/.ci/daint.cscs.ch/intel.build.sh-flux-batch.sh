#!/bin/bash
#FLUX: --job-name=pusheena-pedo-8532
#FLUX: -c=3
#FLUX: --exclusive
#FLUX: --queue="cscsci"
#FLUX: --priority=16

set -o errexit
set -o nounset
set -o pipefail
module swap PrgEnv-cray PrgEnv-intel
module load daint-gpu cudatoolkit CMake/3.14.5
module unload cray-libsci_acc
module load gcc
module list
set -o xtrace  # do not set earlier to avoid noise from module
umask 0002  # make sure group members can access the data
mkdir --mode=0775 -p "${SCRATCH}/${BUILD_TAG}.intel"
cd "${SCRATCH}/${BUILD_TAG}.intel"
cmake \
    -DCMAKE_SYSTEM_NAME=CrayLinuxEnvironment \
    -DUSE_CUDA=ON \
    -DWITH_GPU=P100 \
    -DBLAS_FOUND=ON -DBLAS_LIBRARIES="-lsci_intel_mpi_mp" \
    -DLAPACK_FOUND=ON -DLAPACK_LIBRARIES="-lsci_intel_mpi_mp" \
    -DMPIEXEC_EXECUTABLE="$(command -v srun)" \
    -DTEST_MPI_RANKS=${SLURM_NTASKS} \
    -DTEST_OMP_THREADS=${SLURM_CPUS_PER_TASK} \
    "${WORKSPACE}" |& tee -a "${STAGE_NAME}.out"
make VERBOSE=1 -j |& tee -a "${STAGE_NAME}.out"
