#!/bin/bash
#FLUX: --job-name=task3
#FLUX: --queue=instruction
#FLUX: -t=600
#FLUX: --priority=16

module load nvidia/cuda/11.8.0
nvcc task3.cu vscale.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std=c++17 -o task3
./task3 65536
