#!/bin/bash
#FLUX: --job-name=collatz
#FLUX: --queue=qgpu
#FLUX: -t=10800
#FLUX: --urgency=16

export POCL_CACHE_DIR='${TMPDIR}/kcache'
export LANG='C'
export SERVER_NAME='localhost'

HOME=$HOME
TMPDIR=/tmp
mkdir -p -- "$TMPDIR"
export POCL_CACHE_DIR=${TMPDIR}/kcache
mkdir -p "${POCL_CACHE_DIR}"
export LANG=C
ssh -TN -f -L 5006:localhost:5006 login1
export SERVER_NAME=localhost
echo "hostname=$(hostname)"
echo "pwd=$(pwd)"
echo "HOME=$HOME"
echo "cpu model name=$(cat /proc/cpuinfo | grep "model name" | head -n1)"
echo "cpus=$(cat /proc/cpuinfo | grep processor | wc -l)"
echo "TMPDIR=$TMPDIR"
ml GMP CUDA
nvidia-smi -L
echo "CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES}"
set -u
set -e
umask 077
CC=gcc
if type clang > /dev/null 2> /dev/null && clang --version | grep -qE "version (8|9|10|11|12|13|14|15)"; then
        echo "INFO: clang available"
        CC=clang
fi
SRCDIR=$HOME/collatz/
MAPDIR=$HOME/collatz-sieve/
TMP=$(mktemp -d collatz.XXXXXXXX --tmpdir)
echo "SRCDIR=$SRCDIR"
echo "TMP=$TMP"
mkdir -p -- "$TMP"
pushd -- "$TMP"
cp -r "${SRCDIR}" .
cd collatz/src
make -C gpuworker clean all CC=gcc SIEVE_LOGSIZE=24 USE_SIEVE3=1
make -C mclient clean all
pushd $MAPDIR
./unpack.sh esieve-24 $TMP/collatz/src/gpuworker
popd
cd mclient
stdbuf -o0 -e0 ./mclient -a 14300 -b 7200 -g -d 8
popd
rm -rf -- "$TMP"
rm -rf -- "${POCL_CACHE_DIR}"
