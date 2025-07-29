#!/bin/bash
#SBATCH --job-name=matmul
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:03:00
#SBATCH --constraint=gpu

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
