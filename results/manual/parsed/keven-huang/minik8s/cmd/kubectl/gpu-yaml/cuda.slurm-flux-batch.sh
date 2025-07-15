#!/bin/bash
#FLUX: --job-name=cublas
#FLUX: -c=6
#FLUX: --queue=dgx2
#FLUX: --priority=16

ulimit -s unlimited
ulimit -l unlimited
module load gcc/8.3.0 cuda/10.1.243-gcc-8.3.0
nvcc cuda.cu -o cuda -lcublas
./cuda
