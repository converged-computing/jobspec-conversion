#!/bin/bash
#FLUX: --job-name=swampy-frito-1121
#FLUX: -c=16
#FLUX: -t=7200
#FLUX: --priority=16

export GMP_DIR='$GMP_ROOT'
export MPFR_DIR='$MPFR_ROOT'
export CC='/share/apps/gcc/10.2.0/bin/gcc'
export CXX='/share/apps/gcc/10.2.0/bin/g++'

module purge
module load gcc/10.2.0
module load boost/intel/1.74.0
module load mpfr/gcc/4.1.0
export GMP_DIR=$GMP_ROOT
export MPFR_DIR=$MPFR_ROOT
cd "${SLURM_SUBMIT_DIR}"
SOURCE_DIR=/scratch/${USER}/microstructure_inflators
BUILD_DIR=/scratch/${USER}/microstructure_inflators/build
cd ${BUILD_DIR}
export CC=/share/apps/gcc/10.2.0/bin/gcc
export CXX=/share/apps/gcc/10.2.0/bin/g++
cmake -DTBB_ROOT="/scratch/zh1476/oneTBB/tbb-install/" -DMPFR_INCLUDE_DIR="/share/apps/mpfr/4.1.0/gcc/include" -DMPFR_LIBRARIES="/share/apps/mpfr/4.1.0/gcc/lib/libmpfr.so" -DCMAKE_BUILD_TYPE=release -DLIBIGL_WITH_OPENGL=OFF ${SOURCE_DIR}
make -j16
