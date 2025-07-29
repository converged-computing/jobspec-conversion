#!/bin/bash
#SBATCH --job-name=task2
#SBATCH --output=task2.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=20G
#SBATCH --time=00:10:00
#SBATCH --partition=instruction

module load nvidia/cuda/11.8.0
nvcc task2.cu scan.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std c++17 -o task2
values=(1024 2048 4096 8192 16384 32768 65536)
for val in "${values[@]}"; do
    ./task2 $val 1024
done
