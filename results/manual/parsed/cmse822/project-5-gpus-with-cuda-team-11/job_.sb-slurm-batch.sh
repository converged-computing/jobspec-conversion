#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=v100:1
#SBATCH --time=00:05:00

RANDOM=$$
module load NVHPC/21.9-GCCcore-10.3.0-CUDA-11.4
nvcc final_diffusion_code.cu -o final_diffusion -O3
./final_diffusion.c
