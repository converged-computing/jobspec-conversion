#!/bin/bash
#SBATCH --output=with_gpu.out
#SBATCH --error=with_gpu.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:05:00
#SBATCH --partition=gpu

module load cuda/12.2.2  gcc/10.2   
nvidia-smi
nvcc -O2 src/main.cu
./a.out > out.ppm
python3 ./ppmtojpg.py
echo "done"
