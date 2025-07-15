#!/bin/bash
#FLUX: --job-name=evasive-ricecake-5942
#FLUX: --priority=16

module load gcc/10.2 cmake/3.15.4  ninja/1.9.0 eigen/3.4.0
cd ./
rm -rf data
mkdir -p data
rm -rf build
mkdir -p build
cd build
cmake .. -G Ninja
ninja
./Mat_Solver
