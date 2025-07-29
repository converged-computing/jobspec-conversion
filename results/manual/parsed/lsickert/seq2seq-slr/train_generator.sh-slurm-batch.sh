#!/bin/bash
#SBATCH --job-name=train_generator_model
#SBATCH --mail-user=l.m.sickert@student.rug.nl
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=64GB
#SBATCH --time=12:00:00
#SBATCH --partition=gpu

export HF_DATASETS_CACHE='/scratch/$USER/.cache/huggingface/datasets'

module purge
module load Python/3.8.6-GCCcore-10.2.0
source /data/$USER/.envs/seq2slr/bin/activate
module load PyTorch/1.10.0-fosscuda-2020b
export HF_DATASETS_CACHE="/scratch/$USER/.cache/huggingface/datasets"
python -u main.py --action train_generator --lang en --qual gold,silver --name t5-base --epochs 5
