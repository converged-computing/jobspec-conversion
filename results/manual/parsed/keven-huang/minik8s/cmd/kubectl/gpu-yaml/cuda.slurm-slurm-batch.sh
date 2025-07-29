#!/bin/bash
#SBATCH --job-name=cublas
#SBATCH --output=result/%j.out
#SBATCH --error=result/%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --constraint=ntasks-per-node=1

ulimit -s unlimited
ulimit -l unlimited
module load gcc/8.3.0 cuda/10.1.243-gcc-8.3.0
nvcc cuda.cu -o cuda -lcublas
./cuda
