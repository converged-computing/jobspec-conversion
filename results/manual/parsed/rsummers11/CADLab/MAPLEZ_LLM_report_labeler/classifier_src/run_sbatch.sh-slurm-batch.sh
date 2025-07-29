#!/bin/bash
#SBATCH --output=./dgx_log/slurm-%j.out-%N
#SBATCH --error=./dgx_log/slurm-%j.err-%N
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=60G
#SBATCH --time=4-00:00:00

. ./miniconda3/etc/profile.d/conda.sh
conda activate
conda activate mimic_classifier
torchrun --rdzv-backend=c10d --rdzv-endpoint=localhost:0 --nnodes=1 src/train_pytorch.py "$@"
