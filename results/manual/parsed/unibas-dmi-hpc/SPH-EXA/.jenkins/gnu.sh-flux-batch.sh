#!/bin/bash
#FLUX: --job-name=hello-puppy-9665
#FLUX: --queue=cscsci
#FLUX: --priority=16

set -o errexit
set -o nounset
set -o pipefail
module swap PrgEnv-cray PrgEnv-gnu
module load cdt/22.05
module load nvhpc-nompi/22.2
module load cray-hdf5-parallel/1.12.1.3
module load reframe-cscs-tests
module load daint-gpu
module load CMake
module list -t
CMAKE=cmake
CC --version ;echo
nvcc --version ; echo
$CMAKE --version ;echo
set -o xtrace   # do not set earlier to avoid noise from module
umask 0002      # make sure group members can access the data
RUNDIR=$SCRATCH/$BUILD_TAG.gnu
echo "# WORKSPACE=$WORKSPACE"
echo "# RUNDIR=$RUNDIR"
mkdir -p "$RUNDIR"
chmod 0775 "$RUNDIR"
cd "$RUNDIR"
INSTALLDIR=$RUNDIR/local
rm -fr build
$CMAKE \
-S "${WORKSPACE}" \
-B build \
-DCMAKE_CXX_COMPILER=CC \
-DCMAKE_C_COMPILER=cc \
-DBUILD_TESTING=ON \
-DBUILD_ANALYTICAL=ON \
-DGPU_DIRECT=OFF \
-DCMAKE_CUDA_FLAGS='-arch=sm_60' \
-DCMAKE_BUILD_TYPE=Debug \
-DCMAKE_INSTALL_PREFIX=$INSTALLDIR
$CMAKE --build build -j 12 |& tee -a "${STAGE_NAME}.out"
$CMAKE --install build |& tee -a "${STAGE_NAME}.out"
RFM_TRAP_JOB_ERRORS=1 reframe -r \
--keep-stage-files \
-c $WORKSPACE/.jenkins/reframe_ci.py \
--system daint:gpu \
-n ci_unittests \
-n ci_cputests \
-n ci_gputests \
-J p=cscsci \
-S image=$INSTALLDIR
RFM_TRAP_JOB_ERRORS=1 reframe -r \
--keep-stage-files \
-c $WORKSPACE/.jenkins/reframe_ci.py \
--system daint:gpu \
-n ci_2cn \
-J p=debug \
-S image=$INSTALLDIR
