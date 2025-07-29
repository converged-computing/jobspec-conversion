#!/bin/bash
#SBATCH --job-name=SRWGAN
#SBATCH --output=./scratch/SRWGAN.out
#SBATCH --error=./scratch/SRWGAN.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=20G
#SBATCH --time=05:00:00
#SBATCH --partition=gpu

export PYTHONUNBUFFERED='TRUE'

lscpu
nvidia-smi
export PYTHONUNBUFFERED=TRUE
module load python/3.11.0 openssl/3.0.0 cuda/11.7.1 cudnn/8.6.0
source ../tensorflow.venv/bin/activate
python3 train_SRWGAN.py --trainnum 600 --epochs 40 --batchsz 4 --gpweight 16.0 --cweight 4 --savemodel True
