#!/bin/bash
#SBATCH --job-name=infer
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:a100:2
#SBATCH --mem=50GB
#SBATCH --time=00:59:59
#SBATCH --partition=nvidia
#SBATCH --constraint=80g,ntasks-per-node=1

export TRANSFORMERS_CACHE='/scratch/bc3194/huggingface_cache'
export HF_HOME='/scratch/bc3194/huggingface_cache'

module purge
MODEL=5
NUM_LOOPS=10
source ~/.bashrc
conda activate wizard
export TRANSFORMERS_CACHE="/scratch/bc3194/huggingface_cache"
export HF_HOME="/scratch/bc3194/huggingface_cache"
python -u wizardcoder_infer.py
