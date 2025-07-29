#!/bin/bash
#SBATCH --job-name=get_scores
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=32GB
#SBATCH --time=04:00:00

export HF_DATASETS_CACHE='/scratch/$USER/.cache/huggingface/datasets'
export TRANSFORMERS_CACHE='/scratch/$USER/.cache/huggingface/transformers'
export XDG_CACHE_HOME='/scratch/$USER/.cache'

module purge
module load Python/3.10.4-GCCcore-11.3.0
source $HOME/.envs/rude_nmt/bin/activate
module load PyTorch/1.12.1-foss-2022a-CUDA-11.7.0
export HF_DATASETS_CACHE="/scratch/$USER/.cache/huggingface/datasets"
export TRANSFORMERS_CACHE="/scratch/$USER/.cache/huggingface/transformers"
export XDG_CACHE_HOME="/scratch/$USER/.cache"
python -u get_scores_helper.py
