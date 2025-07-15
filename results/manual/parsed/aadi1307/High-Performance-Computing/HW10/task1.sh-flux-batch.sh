#!/bin/bash
#FLUX: --job-name=task1
#FLUX: --queue=instruction
#FLUX: -t=600
#FLUX: --urgency=16

module load nvidia/cuda/11.8.0
g++ task1.cpp optimize.cpp -Wall -O3 -std=c++17 -o task1 -fno-tree-vectorize
./task1 1000000  
