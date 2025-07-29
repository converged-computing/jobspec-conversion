#!/bin/bash
#FLUX: --job-name=non-local-means
#FLUX: --queue=gpu
#FLUX: -t=120
#FLUX: --urgency=16

module load gcc
module load cuda
nvidia-smi
imageNum=0
patchSize=3
filterSigma=(0.01 0.05 0.1)
patchSigma=(0.8)
useGpu=0
useSharedMem=0
mkdir -p build
nvcc -o build/main -I./include src/main.cu -O3
for i in ${filterSigma[@]}; do
    for j in ${patchSigma[@]}; do
        #run
        ./build/main $imageNum $patchSize $i $j $useGpu $useSharedMem 
    done
done
