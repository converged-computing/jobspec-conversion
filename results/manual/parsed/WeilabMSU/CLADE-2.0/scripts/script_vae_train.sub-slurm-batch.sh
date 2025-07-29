#!/bin/bash
#SBATCH --job-name=vaetrain
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=23:59:00
#SBATCH --array=1-5

source activate deep_sequence
dataset=GB1
THEANO_FLAGS='floatX=float32,device=cuda' python src/vae_train.py Input/"$dataset"/"$dataset".a2m "$dataset"_seed$[$SLURM_ARRAY_TASK_ID] $[$SLURM_ARRAY_TASK_ID]
