#!/bin/bash
#FLUX: --job-name=reclusive-bits-5194
#FLUX: --urgency=16

module load cuda/12.2.2  gcc/10.2   
nvidia-smi 
nvcc -O2 -std=c++11 hw4.cu -o a.out
nvprof ./a.out
nsys profile ./a.out
