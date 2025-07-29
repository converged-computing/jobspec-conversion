#!/bin/bash
#SBATCH --job-name=general
#SBATCH --output=logs/%x-%j.out
#SBATCH --error=logs/%x-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=30480
#SBATCH --time=3-00:00:00
#SBATCH --partition=nodes
#SBATCH --chdir=/cluster/raid/home/zhivar.sourati/ExplagraphGen

echo $(pwd)
nvidia-smi
echo $CUDA_VISIBLE_DEVICES
eval "$(conda shell.bash hook)"
conda activate explagraphgen
bash scripts/train_graph_contrastive.sh
conda deactivate
