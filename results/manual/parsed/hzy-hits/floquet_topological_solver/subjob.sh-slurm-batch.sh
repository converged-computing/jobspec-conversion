#!/bin/bash
#SBATCH --output=with_gpu.out
#SBATCH --error=with_gpu.err
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --time=10:30:00

module load gcc/10.2 cmake/3.15.4  ninja/1.9.0 eigen/3.4.0
cd ./
rm -rf data
mkdir -p data
rm -rf build
mkdir -p build
cd build
cmake .. -G Ninja
ninja
./Mat_Solver
