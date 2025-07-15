#!/bin/bash
#FLUX: --job-name=tart-dog-2630
#FLUX: --urgency=16

date
module purge
module load compiler/devtoolset/7.3.1
module load compiler/rocm/dtk-22.10.1 
module load mpi/hpcx/2.11.0/gcc-7.3.1
module add compiler/cmake/3.15.6
module list
./gencode.sh
cd 3rdparty/jsoncpp
mkdir -p build
cd build && rm -rf ./*
cmake ../ && make clean && make -j16
cd ../../../
make clean
dbg=0 make -j16 all
