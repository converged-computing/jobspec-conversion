#!/bin/bash
#FLUX: --job-name=collatz
#FLUX: --queue=standard-g
#FLUX: -t=10800
#FLUX: --urgency=16

export POCL_CACHE_DIR='${TMPDIR}/kcache'
export LANG='C'
export SERVER_NAME='pcbarina.fit.vutbr.cz'

HOME=$HOME
TMPDIR=/tmp
mkdir -p -- "$TMPDIR"
export POCL_CACHE_DIR=${TMPDIR}/kcache
mkdir -p "${POCL_CACHE_DIR}"
export LANG=C
export SERVER_NAME=pcbarina.fit.vutbr.cz
echo "hostname=$(hostname)"
echo "pwd=$(pwd)"
echo "HOME=$HOME"
echo "cpu model name=$(cat /proc/cpuinfo | grep "model name" | head -n1)"
echo "cpus=$(cat /proc/cpuinfo | grep processor | wc -l)"
echo "TMPDIR=$TMPDIR"
set -u
set -e
umask 077
CC=gcc
SRCDIR=$HOME/collatz/
MAPDIR=$HOME/collatz-sieve/
TMP=$(mktemp -d collatz.XXXXXXXX --tmpdir)
echo "SRCDIR=$SRCDIR"
echo "TMP=$TMP"
mkdir -p -- "$TMP"
pushd -- "$TMP"
cp -r "${SRCDIR}" .
cd collatz/src
module load PrgEnv-amd
make -C gpuworker clean all SIEVE_LOGSIZE=24 USE_SIEVE3=1 USE_LUMI=1
module load PrgEnv-gnu
make -C mclient clean all
pushd $MAPDIR
./unpack.sh esieve-24 $TMP/collatz/src/gpuworker
popd
cd mclient
stdbuf -o0 -e0 ./mclient -a 14300 -b 7200 -g -d -B 8
popd
rm -rf -- "$TMP"
rm -rf -- "${POCL_CACHE_DIR}"
