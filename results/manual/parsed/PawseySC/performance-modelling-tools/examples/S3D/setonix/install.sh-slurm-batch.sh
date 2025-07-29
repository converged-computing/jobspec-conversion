#!/bin/bash
#SBATCH --account=pawsey0007-gpu
#SBATCH --output=install.out
#SBATCH --error=install.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gpus-per-task=1
#SBATCH --partition=gpu-dev

CODENAME="S3D"
REPO="git@github.com:unsw-edu-au/S3D_JICF.git"
GIT_BRANCH="pacer_cleanup"
ROCM_VERSION="5.0.2"
MACH="STXgpu"
CHECKOUT_DIR=${CODENAME}_${GIT_BRANCH}_${MACH}_rocm-${ROCM_VERSION}
cwd=$(pwd)
if [ ! -e ${CODENAME}_${GIT_BRANCH} ] ; then
 git clone ${REPO} ${CHECKOUT_DIR}
fi
cd ${cwd}/${CHECKOUT_DIR}
git checkout ${GIT_BRANCH}
module load PrgEnv-cray/8.3.3 craype-accel-amd-gfx90a
module load rocm/$ROCM_VERSION
cd ${cwd}/${CHECKOUT_DIR}/build
export MACH
make
