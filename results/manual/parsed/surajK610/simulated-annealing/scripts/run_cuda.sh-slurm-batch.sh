#!/bin/bash
#SBATCH --output=outputs/with_gpu.out
#SBATCH --error=outputs/with_gpu.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:05:00
#SBATCH --partition=3090-gcondo

echo "Current Working Directory (CWD): $(pwd)"
module load cuda/12.2.2  gcc/10.2   
module load cmake
module load googletest
echo "Files in CWD:"
ls
echo "NVCC Compile:"
nvcc -O2 ./src/schwefel/schwefel_cuda.cu -o ./src/schwefel/schwefel_cuda
echo "Profile:"
chmod +x ./src/schwefel/schwefel_cuda
nsys profile --stats=true --force-overwrite=true --output=outputs/gpu_report ./src/schwefel/schwefel_cuda
