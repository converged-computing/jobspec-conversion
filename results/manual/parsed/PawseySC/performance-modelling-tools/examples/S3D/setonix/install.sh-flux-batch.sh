#!/bin/bash
#FLUX: --job-name=swampy-lamp-9546
#FLUX: -c=16
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu-dev
#FLUX: --urgency=16

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
