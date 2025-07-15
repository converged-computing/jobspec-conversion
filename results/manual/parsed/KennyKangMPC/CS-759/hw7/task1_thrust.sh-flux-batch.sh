#!/bin/bash
#FLUX: --job-name=chunky-animal-5479
#FLUX: --urgency=16

module load cuda
nvcc task1_thrust.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -o task1_thrust
for i in {10..30}; do
  n=$((2 ** i))
  echo "Running with n = 2^$i = $n"
  ./task1_thrust $n
  echo
done
