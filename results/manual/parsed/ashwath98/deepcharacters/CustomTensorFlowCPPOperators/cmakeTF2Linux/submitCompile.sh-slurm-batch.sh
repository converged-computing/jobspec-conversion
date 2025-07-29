#!/bin/bash
#SBATCH --output=output/out-%j.out
#SBATCH --error=output/err-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=2-00:00:00

echo "using GPU ${CUDA_VISIBLE_DEVICES}"
cd ../build/Linux
make -j 32
