#!/bin/bash
#SBATCH --job-name=flux-gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH --time=00:10:00

module purge
module load julia/1.5.0 cudatoolkit/11.0 cudnn/cuda-11.0/8.0.2
julia conv_mnist.jl
