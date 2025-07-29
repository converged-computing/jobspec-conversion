#!/bin/bash
#FLUX: --job-name=task2
#FLUX: --queue=instruction
#FLUX: -t=600
#FLUX: --urgency=16

module load nvidia/cuda/11.8.0
nvcc task2.cu scan.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std c++17 -o task2
values=(1024 2048 4096 8192 16384 32768 65536)
for val in "${values[@]}"; do
    ./task2 $val 1024
done
