#!/bin/bash
#FLUX: --job-name=air_sim
#FLUX: --queue=gpu
#FLUX: -t=576000
#FLUX: --priority=16

module load cuda
nvidia-smi
cd air_sim
nvcc kernel.cu -o kernel -std=c++11
./kernel
