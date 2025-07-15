#!/bin/bash
#FLUX: --job-name=pusheena-punk-6021
#FLUX: --urgency=16

module load cuda/11.7.1  gcc/10.2 cmake/3.15.4  ninja/1.9.0
nvcc --version
cd ./
rm -rf data
mkdir -p data
rm -rf build
mkdir -p build
cd build
nvidia-smi 
cmake .. -G Ninja
ninja
nsys profile ./final_project
