#!/bin/bash
#SBATCH --job-name=task1
#SBATCH --output=task1.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=20G
#SBATCH --time=00:10:00
#SBATCH --partition=instruction

module load nvidia/cuda/11.8.0
nvcc task1.cu mmul.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -lcublas -std c++17 -o task1
values=(32 64 128 256 512 1024 2048)
for val in "${values[@]}"; do
    ./task1 $val 69
done
