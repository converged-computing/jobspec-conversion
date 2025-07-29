#!/bin/bash
#SBATCH --job-name=air_sim
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:P100:1
#SBATCH --time=6-16:00:00
#SBATCH --partition=gpu
#SBATCH --qos=normal

module load cuda
nvidia-smi
cd air_sim
nvcc kernel.cu -o kernel -std=c++11
./kernel
