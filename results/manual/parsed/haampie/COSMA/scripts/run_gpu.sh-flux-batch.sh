#!/bin/bash
#FLUX: --job-name=matmul
#FLUX: -N=4
#FLUX: -t=180
#FLUX: --urgency=16

export CC='`which cc`'
export CXX='`which CC`'
export CRAYPE_LINK_TYPE='dynamic'
export CRAY_CUDA_MPS='1'

module load daint-gpu
module swap PrgEnv-cray PrgEnv-gnu
module unload cray-libsci
module load intel
module load CMake
module load cudatoolkit
export CC=`which cc`
export CXX=`which CC`
export CRAYPE_LINK_TYPE=dynamic
export CRAY_CUDA_MPS=1
n_iter=1 srun -u -N 4 -n 48 ./build/miniapp/cosma-miniapp -m 25000 -n 25000 -k 25000 -P 48
