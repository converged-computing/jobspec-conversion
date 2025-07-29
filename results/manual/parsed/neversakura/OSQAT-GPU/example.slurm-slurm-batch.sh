#!/bin/bash
#SBATCH --output=./output/JOB.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:30:00

JULIA_DEBUG=CUDA julia src/JOB.jl
