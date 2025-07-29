#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --gres=gpu:1
#SBATCH --mem=64g
#SBATCH --time=3-00:00:00
#SBATCH --partition=gpu_high
#SBATCH --nodelist=compute-1-5

module load singularity # this is for singularity
ulimit -n 40000 # this is for singularity and large memory jobs, you could change 40000 to suitable numbers
kill -9 $(nvidia-smi | sed -n 's/|\s*[0-9]*\s*\([0-9]*\)\s*.*/\1/p' | sort | uniq | sed '/^$/d')
CUDA_VISIBLE_DEVICES=0 python xxx.py
