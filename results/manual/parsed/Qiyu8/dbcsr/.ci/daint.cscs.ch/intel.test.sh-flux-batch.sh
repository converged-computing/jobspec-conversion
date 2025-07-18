#!/bin/bash
#FLUX: --job-name=reclusive-punk-7847
#FLUX: -c=3
#FLUX: --queue=cscsci
#FLUX: --urgency=16

export CRAY_CUDA_MPS='1 # enable the CUDA proxy for MPI+CUDA'
export OMP_PROC_BIND='TRUE # set thread affinity'

set -o errexit
set -o nounset
set -o pipefail
module swap PrgEnv-cray PrgEnv-intel
module load daint-gpu cudatoolkit cdt-cuda
module load /apps/daint/UES/jenkins/7.0.UP02/gpu/easybuild/modules/all/CMake/3.18.4
module unload cray-libsci_acc
module list
set -o xtrace  # do not set earlier to avoid noise from module
umask 0002  # make sure group members can access the data
mkdir -p "${SCRATCH}/${BUILD_TAG}.intel"
chmod 0775 "${SCRATCH}/${BUILD_TAG}.intel"
cd "${SCRATCH}/${BUILD_TAG}.intel"
export CRAY_CUDA_MPS=1 # enable the CUDA proxy for MPI+CUDA
export OMP_PROC_BIND=TRUE # set thread affinity
env |& tee -a "${STAGE_NAME}.out"
env CTEST_OUTPUT_ON_FAILURE=1 make test ARGS="--timeout 1200" |& tee -a "${STAGE_NAME}.out"
