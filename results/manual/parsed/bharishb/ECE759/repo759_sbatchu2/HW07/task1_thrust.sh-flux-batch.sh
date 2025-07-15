#!/bin/bash
#FLUX: --job-name=eccentric-salad-0847
#FLUX: --priority=16

module load nvidia/cuda/11.8.0 
nvcc task1_thrust.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std c++17 -o task1_thrust
./task1_thrust 10000 1024
