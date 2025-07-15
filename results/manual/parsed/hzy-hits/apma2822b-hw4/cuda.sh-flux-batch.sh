#!/bin/bash
#FLUX: --job-name=blank-avocado-5966
#FLUX: --priority=16

module load cuda/12.2.2  gcc/10.2   
nvidia-smi 
nvcc -O2 -std=c++11 hw4.cu -o a.out
nvprof ./a.out
nsys profile ./a.out
