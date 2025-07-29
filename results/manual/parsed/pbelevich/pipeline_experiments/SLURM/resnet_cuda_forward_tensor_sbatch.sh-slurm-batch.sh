#!/bin/bash
#SBATCH --job-name=resnet_cuda_forward_tensor_sbatch
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --time=01:00:00

srun --label resnet_cuda_forward_tensor.sh
