#!/bin/bash
#SBATCH --output=tmp/%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gpus-per-task=1

PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:64 pasero-decode $@
