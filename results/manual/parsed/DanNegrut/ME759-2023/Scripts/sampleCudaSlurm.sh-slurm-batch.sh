#!/bin/bash
#SBATCH --job-name=CudaHello
#SBATCH --output=cuda_hello-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:03:00
#SBATCH --partition=instruction

module load nvidia/cuda/11.8.0
nvcc cudaHello.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std c++17 -o cudaHello
./cudaHello
