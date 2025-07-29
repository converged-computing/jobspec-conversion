#!/bin/bash
#SBATCH --job-name=MV_GPU
#SBATCH --output=./Results/job-%J.out
#SBATCH --error=./Results/job-%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=40G
#SBATCH --time=00:35:00
#SBATCH --partition=gpu

nvidia-smi
module load cuda/11.2.0 gcc/10.2
nvcc -arch sm_75 -c MV_GPU.cu -o MV_GPU.o
nvcc -arch sm_75 -c main.cu -o main.o
g++ -c MyUtils.cpp -o MyUtils.o
nvcc main.o MV_GPU.o MyUtils.o -o testMV_GPU.o
rm main.o MV_GPU.o MyUtils.o
./testMV_GPU.o
