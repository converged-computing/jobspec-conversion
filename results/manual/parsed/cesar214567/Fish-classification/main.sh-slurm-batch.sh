#!/bin/bash
#SBATCH --job-name=cesar_AI
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32GB
#SBATCH --partition=investigacion
#SBATCH --nodelist=g001

export PATH='/usr/local/cuda-11.4/targets/x86_64-linux/lib:$PATH'
export LD_LIBRARY_PATH='/usr/local/cuda-11.4/lib64:$LD_LIBRARY_PATH'
export PYTORCH_CUDA_ALLOC_CONF='max_split_size_mb:100'

module load gcc/9.2.0
module load cuda/11.4
module load python/3.9.2
export PATH=/usr/local/cuda-11.4/targets/x86_64-linux/lib:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-11.4/lib64:$LD_LIBRARY_PATH
export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:100
python3.9 main22.py
