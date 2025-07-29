#!/bin/bash
#SBATCH --job-name=c_def
#SBATCH --output=c_def.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=2-00:00:00
#SBATCH --qos=batch
#SBATCH --constraint=gpu_12gb

module purge
module load python-3.5 cuda-8.0
USE_CUDA=1 python3 -u model.py --modelname c_default --server 1
