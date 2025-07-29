#!/bin/bash
#SBATCH --output=with_gpu.out
#SBATCH --error=with_gpu.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=64G
#SBATCH --time=01:30:00
#SBATCH --partition=gpu

module load cuda/11.7.1  gcc/10.2 cmake/3.15.4  ninja/1.9.0
nvcc --version
cd ./
rm -rf data
mkdir -p data
rm -rf build
mkdir -p build
cd build
nvidia-smi 
cmake .. -G Ninja
ninja
nsys profile ./final_project
