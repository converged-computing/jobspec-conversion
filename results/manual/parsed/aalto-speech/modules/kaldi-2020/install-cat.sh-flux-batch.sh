#!/bin/bash
#FLUX: --job-name=strawberry-hobbit-2735
#FLUX: -c=20
#FLUX: --queue=coin,batch-ivb,batch-hsw,short-ivb,short-hsw,batch-csl,batch-skl
#FLUX: -t=3600
#FLUX: --urgency=16

source ../common/common.sh
PROFILE=${1:-triton-gcc-openblas-2020}
module purge
source profiles/${PROFILE}
module list
NAME=kaldi-cat
GIT_REPO=https://github.com/kaldi-asr/kaldi.git
GIT_DIR=src
init_vars
checkout_git
pushd ${BUILD_DIR}/src
./configure --fst-root="/scratch/elec/puhe/Modules/opt/openfst/$OPENFST" --fst-version="$OPENFST_VERSION" \
            --cub-root="/scratch/elec/puhe/Modules/opt/CUB/cub-$CUB" \
            --mathlib=OPENBLAS --openblas-root="/share/apps/easybuild/software/OpenBLAS/$OPENBLAS" \
            --cudatk-dir="/share/apps/spack/envs/fgci-centos7-generic/software/cuda/$CUDA/6e7kenm" 
make -j clean depend
make -j $SLURM_CPUS_PER_TASK
exit 0
rm -Rf "${INSTALL_DIR}"
mkdir -p ${INSTALL_DIR}/{bin,testbin}
find . -type f -executable -print | grep "bin/" | grep -v "\.cc$" | grep -v "so$" | grep -v test | xargs cp -t "${INSTALL_DIR}/bin"
find . -type f -executable -print | grep -v "\.cc$" | grep -v "so$" | grep test | xargs cp -t "${INSTALL_DIR}/testbin"
popd
BIN_PATH=${INSTALL_DIR}/bin
EXTRA_LINES="module load GCC/$GCC openfst/$OPENFST CUB/$CUB cuda/$CUDA OpenBLAS/$OPENBLAS sctk/$SCTK sph2pipe/$SPH sox
setenv KALDI_INSTALL_DIR ${INSTALL_DIR}"
DESC="Kaldi Speech Recognition Toolkit"
HELP="Kaldi ${VERSION} ${TOOLCHAIN}"
write_module
rm -Rf ${BUILD_DIR}
