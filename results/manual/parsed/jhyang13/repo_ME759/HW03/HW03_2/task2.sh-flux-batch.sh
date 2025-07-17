#!/bin/bash
#FLUX: --job-name=task2
#FLUX: --queue=instruction
#FLUX: -t=1800
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
module load nvidia/cuda/11.8.0
nvcc task2.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std=c++17 -o task2
./task2
