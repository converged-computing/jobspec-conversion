#!/bin/bash
#SBATCH --job-name=project
#SBATCH --output=%x.out
#SBATCH --error=%x.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00
#SBATCH --partition=wacc

module load nvidia/cuda/11.6.0
nvcc *.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -lcuda -lcublas -std c++17 -o CNN
echo "Running the code"
./CNN
