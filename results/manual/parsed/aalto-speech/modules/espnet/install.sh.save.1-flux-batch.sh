#!/bin/bash
#FLUX: --job-name=scruptious-plant-5526
#FLUX: -c=5
#FLUX: -t=3600
#FLUX: --urgency=16

export PATH='$CUDAROOT/bin:$PATH'
export LD_LIBRARY_PATH='$CUDAROOT/lib64:$LD_LIBRARY_PATH'
export CFLAGS='-I$CUDAROOT/include $CFLAGS'
export CPATH='$CUDAROOT/include:$CPATH'
export CUDA_HOME='$CUDAROOT'
export CUDA_PATH='$CUDAROOT'
export TMPDIR='$(pwd)/build-tmp'

KALDI_VERSION="7637de7-GCC-6.4.0-2.28-OPENBLAS"
KALDI_DIR_SUFIX="7637de7-6.4.0-2.28"
CUDA_VERSION=10.0.130
module load kaldi-vanilla/${KALDI_VERSION} anaconda3 cmake nvidia-torch cuda/${CUDA_VERSION}
CUDAROOT=/share/apps/spack/software/cuda/${CUDA_VERSION}
export PATH=$CUDAROOT/bin:$PATH
export LD_LIBRARY_PATH=$CUDAROOT/lib64:$LD_LIBRARY_PATH
export CFLAGS="-I$CUDAROOT/include $CFLAGS"
export CPATH=$CUDAROOT/include:$CPATH
export CUDA_HOME=$CUDAROOT
export CUDA_PATH=$CUDAROOT
NAME="espnet-2020"
GIT_REPO=https://github.com/espnet/espnet
SCRIPT_DIR=$(pwd)
MODULE_ROOT="${MODULE_ROOT:-${GROUP_DIR}/Modules}"
OPT_DIR="${MODULE_ROOT}/opt/${NAME}"
MODULE_DIR="${MODULE_ROOT}/modulefiles/${NAME}"
mkdir -p "${OPT_DIR}"
mkdir -p "${MODULE_DIR}"
pushd "${OPT_DIR}"
git clone "$GIT_REPO" espnet
GIT_HASH=$(git --git-dir=espnet/.git rev-parse --short HEAD)
VERSION="$GIT_HASH"
BUILD_DIR="$OPT_DIR"/"espnet-$GIT_HASH"
if [ -d "$BUILD_DIR" ]; then
  echo "$BUILD_DIR already exists. Remove it if you want to overwrite the module."
  rm -rf espnet
  exit 1
fi
mv -n espnet "$BUILD_DIR"
pushd "$BUILD_DIR"/tools
KALDI_ROOT=${GROUP_DIR}/Modules/opt/kaldi-vanilla/kaldi-${KALDI_DIR_SUFIX}
export TMPDIR=$(pwd)/build-tmp
mkdir -p $TMPDIR
chmod 777 $TMPDIR
sed -i 's/pip install [.]/rm -rf .git \&\& rm -rf ext\/warp-ctc\/.git \&\& pip install ./g' install_chainer_ctc.sh
make KALDI=${KALDI_ROOT}  
module purge
