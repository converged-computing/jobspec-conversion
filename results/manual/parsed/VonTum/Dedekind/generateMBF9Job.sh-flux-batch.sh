#!/bin/bash
#FLUX: --job-name=psycho-fudge-5193
#FLUX: --exclusive
#FLUX: --priority=16

module load devel/CMake/3.21.1-GCCcore-11.2.0 fpga bittware/520n intel/opencl_sdk
./production parallelizeMBF9GenerationAcrossAllCores:262144
