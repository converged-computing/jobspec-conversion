#!/bin/bash
#FLUX: --job-name=CudaHello
#FLUX: --queue=instruction
#FLUX: -t=180
#FLUX: --priority=16

module load nvidia/cuda/11.8.0
nvcc cudaHello.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std c++17 -o cudaHello
./cudaHello
