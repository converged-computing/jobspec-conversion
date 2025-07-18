#!/bin/bash
#FLUX: --job-name=task1
#FLUX: --queue=instruction
#FLUX: -t=600
#FLUX: --urgency=16

module load nvidia/cuda/11.8.0
nvcc task1.cu mmul.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -lcublas -std c++17 -o task1
values=(32 64 128 256 512 1024 2048)
for val in "${values[@]}"; do
    ./task1 $val 69
done
