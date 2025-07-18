#!/bin/bash
#FLUX: --job-name=project
#FLUX: --queue=wacc
#FLUX: -t=3600
#FLUX: --urgency=16

module load nvidia/cuda/11.6.0
nvcc *.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -lcuda -lcublas -std c++17 -o CNN
echo "Running the code"
./CNN
