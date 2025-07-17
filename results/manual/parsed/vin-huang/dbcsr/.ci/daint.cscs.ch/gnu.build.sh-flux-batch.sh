#!/bin/bash
#FLUX: --job-name=peachy-mango-1872
#FLUX: -c=3
#FLUX: --exclusive
#FLUX: --queue=cscsci
#FLUX: --urgency=16

set -o errexit
set -o nounset
set -o pipefail
module swap PrgEnv-cray PrgEnv-gnu
module load daint-gpu cudatoolkit CMake/3.14.5
module unload cray-libsci_acc
module list
set -o xtrace  # do not set earlier to avoid noise from module
umask 0002  # make sure group members can access the data
mkdir --mode=0775 -p "${SCRATCH}/${BUILD_TAG}.gnu"
cd "${SCRATCH}/${BUILD_TAG}.gnu"
cmake \
    -DCMAKE_SYSTEM_NAME=CrayLinuxEnvironment \
    -DCMAKE_CROSSCOMPILING_EMULATOR="" \
    -DUSE_CUDA=ON \
    -DUSE_CUBLAS=ON \
    -DWITH_GPU=P100 \
    -DBLAS_FOUND=ON -DBLAS_LIBRARIES="-lsci_gnu_mpi_mp" \
    -DLAPACK_FOUND=ON -DLAPACK_LIBRARIES="-lsci_gnu_mpi_mp" \
    -DMPIEXEC_EXECUTABLE="$(command -v srun)" \
    -DTEST_MPI_RANKS=${SLURM_NTASKS} \
    -DTEST_OMP_THREADS=${SLURM_CPUS_PER_TASK} \
    "${WORKSPACE}" |& tee -a "${STAGE_NAME}.out"
make VERBOSE=1 -j |& tee -a "${STAGE_NAME}.out"
