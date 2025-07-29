#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:2

lscpu
nvidia-smi
conda env update --file environment_gpu.yml --name ariadne_gpu
source ~/miniconda3/etc/profile.d/conda.sh
conda activate ariadne_gpu
"$@"
