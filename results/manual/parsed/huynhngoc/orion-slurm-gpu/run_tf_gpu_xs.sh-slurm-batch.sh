#!/bin/bash
#SBATCH --job-name=gpu_tf
#SBATCH --output=outputs/gpu-xs-%A.out
#SBATCH --error=outputs/gpu-xs-%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16G
#SBATCH --partition=gpu

module load singularity
nvidia-modprobe -u -c=0
singularity exec --nv tensorflow_gpu.sif python scripts/run_tensorflow_xs.py
