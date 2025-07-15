#!/bin/bash
#FLUX: --job-name=outstanding-pedo-5112
#FLUX: --priority=16

nvidia-smi
module load cuda/11.2.0 gcc/10.2
nvcc -arch sm_75 -c MV_GPU.cu -o MV_GPU.o
nvcc -arch sm_75 -c main.cu -o main.o
g++ -c MyUtils.cpp -o MyUtils.o
nvcc main.o MV_GPU.o MyUtils.o -o testMV_GPU.o
rm main.o MV_GPU.o MyUtils.o
./testMV_GPU.o
