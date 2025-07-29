#!/bin/bash
#SBATCH --job-name=hogan
#SBATCH --output=./output/mandelbrot_cuda.o
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:02:00

module load gcc/9.2.0
module load cmake/gcc/3.18.0
module load openmpi/gcc/64/1.10.7
module load nvidia_hpcsdk
cd build
rm -rf *
cmake ..
make
./mandelbrot_cuda pic.ppm
