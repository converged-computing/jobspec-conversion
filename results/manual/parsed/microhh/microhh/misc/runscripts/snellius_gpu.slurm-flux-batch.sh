#!/bin/bash
#FLUX: --job-name=rico
#FLUX: -c=18
#FLUX: --queue=gpu
#FLUX: --priority=16

module purge
module load 2021
module load CMake/3.20.1-GCCcore-10.3.0
module load foss/2021a
module load netCDF/4.8.0-gompi-2021a
module load CUDA/11.3.1
./microhh init rico
./microhh run rico
