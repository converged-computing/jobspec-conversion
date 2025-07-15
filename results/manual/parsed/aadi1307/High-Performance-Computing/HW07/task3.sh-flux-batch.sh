#!/bin/bash
#FLUX: --job-name=task3
#FLUX: -c=4
#FLUX: --queue=instruction
#FLUX: -t=600
#FLUX: --urgency=16

module load nvidia/cuda/11.8.0
g++ task3.cpp -Wall -O3 -std=c++17 -o task3 -fopenmp
./task3
