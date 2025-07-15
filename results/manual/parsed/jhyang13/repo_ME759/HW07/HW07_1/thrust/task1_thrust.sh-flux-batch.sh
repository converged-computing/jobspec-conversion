#!/bin/bash
#FLUX: --job-name=task1_thrust
#FLUX: --queue=instruction
#FLUX: -t=1800
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
module load nvidia/cuda/11.8.0 
module load gcc/11.3.0
nvcc task1_thrust.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std c++17 -o task1_thrust
./task1_thrust 10
