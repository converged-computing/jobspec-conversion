#!/bin/bash
#FLUX: --job-name=lovable-diablo-8184
#FLUX: --urgency=16

echo "Current Working Directory (CWD): $(pwd)"
module load cuda/12.2.2  gcc/10.2   
module load cmake
module load googletest
echo "Files in CWD:"
ls
echo "NVCC Compile:"
nvcc -O2 ./src/schwefel/schwefel_cuda.cu -o ./src/schwefel/schwefel_cuda
echo "Profile:"
chmod +x ./src/schwefel/schwefel_cuda
nsys profile --stats=true --force-overwrite=true --output=outputs/gpu_report ./src/schwefel/schwefel_cuda
