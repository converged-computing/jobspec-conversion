#!/bin/bash
#FLUX: --job-name=conspicuous-peanut-butter-0498
#FLUX: --priority=16

export PATH='${PATH}:${HIP_PATH}'

module load PrgEnv-gnu/8.3.3
module load hip/5.4.3
module load PrgEnv-nvidia/8.3.3
module load cmake
export PATH=${PATH}:${HIP_PATH}
cd ~/hip-training-series/Lecture2/HIPIFY/mini-nbody/cuda
../../hipify-perl -print-stats nbody-orig.cu > nbody-orig.cpp
hipcc -DSHMOO -I ../ nbody-orig.cpp -o nbody-orig
srun ./nbody-orig
rm nbody-orig nbody-orig.cpp
