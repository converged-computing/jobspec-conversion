#!/bin/bash
#SBATCH --job-name=run_infer
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=10GB
#SBATCH --time=01:59:59
#SBATCH --partition=nvidia
#SBATCH --constraint=80g,ntasks-per-node=1

export TRANSFORMERS_CACHE='/scratch/[your NetID]/huggingface_cache'

module purge
source ~/.bashrc
conda activate [your conda env]
export TRANSFORMERS_CACHE="/scratch/[your NetID]/huggingface_cache"
python -u infer_codegen.py
