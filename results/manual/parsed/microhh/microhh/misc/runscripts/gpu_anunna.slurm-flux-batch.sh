#!/bin/bash
#FLUX: --job-name=microhh
#FLUX: --queue=gpu
#FLUX: --priority=16

module load cuda/10.1
module load netcdf/gcc/64/4.6.1
module load fftw3/gcc/64/3.3.8
module load hdf5/gcc/64/1.10.1
module unload intel
module unload gcc
module load gcc/7.1.0
module unload python
module load python/3.7.1
./microhh init bomex
./microhh run bomex
