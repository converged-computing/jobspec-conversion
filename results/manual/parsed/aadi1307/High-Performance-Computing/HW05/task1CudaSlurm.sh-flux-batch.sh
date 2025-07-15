#!/bin/bash
#FLUX: --job-name=task1
#FLUX: --queue=instruction
#FLUX: -t=600
#FLUX: --priority=16

module load nvidia/cuda/11.8.0
nvcc task1.cu matmul.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std c++17 -o task1
values=(32 64 128 256 512 1024 2048)
for val in "${values[@]}"; do
    ./task1 $val 16
done
