#!/bin/bash
#SBATCH --job-name=example
#SBATCH --output=%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=2GB
#SBATCH --time=00:05:00

module load modenv/hiera GCC/10.2.0 CUDA/11.1.1 OpenMPI/4.0.5 PyTorch/1.10.0 tqdm/4.56.2
myworkspace="$(ws_find myworkspace)"
python "$myworkspace"/src/myscript.py
