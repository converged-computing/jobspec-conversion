#!/bin/bash
#SBATCH --job-name=nn
#SBATCH --output=nn.out
#SBATCH --error=nn.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=40G
#SBATCH --time=00:20:00
#SBATCH --partition=instruction

module load nvidia/cuda/11.8.0 gcc/.11.3.0_cuda
make clean
make
./nn
