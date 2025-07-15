#!/bin/bash
#FLUX: --job-name=hpx-test
#FLUX: --queue=jenkins-compute
#FLUX: -t=7200
#FLUX: --priority=16

export CC='gcc'
export CXX='g++'

module purge
module load gcc
module load cmake
module load boost
module load hwloc
module load openmpi
module load papi
module load python
export CC=gcc
export CXX=g++
PATH_TO_EXE=${1:-./init/build/}
cd ${PATH_TO_EXE}
time ninja tests
time ctest --verbose --timeout 300
