#!/bin/bash
#FLUX: --job-name=goodbye-pot-4145
#FLUX: -c=3
#FLUX: --exclusive
#FLUX: --queue=cscsci
#FLUX: --urgency=16

set -o errexit
set -o nounset
set -o pipefail
module load daint-gpu cudatoolkit CMake/3.14.5
module unload cray-libsci_acc
module load gcc
module list
set -o xtrace  # do not set earlier to avoid noise from module
umask 0002  # make sure group members can access the data
mkdir --mode=0775 -p "${SCRATCH}/${BUILD_TAG}.cray"
cd "${SCRATCH}/${BUILD_TAG}.cray"
cmake \
    -DCMAKE_SYSTEM_NAME=CrayLinuxEnvironment \
    -DUSE_CUDA=ON \
    -DWITH_GPU=P100 \
    -DBLAS_FOUND=ON -DBLAS_LIBRARIES="-lsci_cray_mpi_mp" \
    -DLAPACK_FOUND=ON -DLAPACK_LIBRARIES="-lsci_cray_mpi_mp" \
    -DMPIEXEC_EXECUTABLE="$(command -v srun)" \
    -DMPIEXEC_PREFLAGS="-u" \
    -DTEST_MPI_RANKS=${SLURM_NTASKS} \
    -DTEST_OMP_THREADS=${SLURM_CPUS_PER_TASK} \
    "${WORKSPACE}" |& tee -a "${STAGE_NAME}.out"
make VERBOSE=1 -j |& tee -a "${STAGE_NAME}.out"
