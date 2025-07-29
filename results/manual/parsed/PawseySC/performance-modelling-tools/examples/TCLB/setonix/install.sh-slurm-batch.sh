#!/bin/bash
#SBATCH --account=pawsey0007-gpu
#SBATCH --output=install.out
#SBATCH --error=install.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gpus-per-task=1
#SBATCH --partition=gpu-dev

CODENAME="TCLB"
REPO="https://github.com/FluidNumerics/TCLB.git"
GIT_BRANCH="launch_bounds_64_6"
ROCM_VERSION="5.0.2"
APP=d3q27_PSM_NEBB
CHECKOUT_DIR=${CODENAME}_${GIT_BRANCH}_rocm-${ROCM_VERSION}
cwd=$(pwd)
if [ ! -e ${CODENAME}_${GIT_BRANCH} ] ; then
 git clone ${REPO} ${CHECKOUT_DIR}
fi
cd ${CHECKOUT_DIR}
git checkout ${GIT_BRANCH}
module load rocm/$ROCM_VERSION
module load r/4.1.0
tools/install.sh rdep 
make configure
./configure --enable-hip \
	    --with-cpp-flags="-Rpass-analysis=kernel-resource-usage" \
	    --with-mpi-include=${CRAY_MPICH_DIR}/include \
	    --with-mpi-lib=${CRAY_MPICH_DIR}/lib
make -j ${APP} 
