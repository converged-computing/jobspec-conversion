#!/bin/bash
#SBATCH --job-name=julia_gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4G
#SBATCH --time=00:05:00
#SBATCH --constraint=a100

module purge
module load julia/1.8.2
julia svd.jl
