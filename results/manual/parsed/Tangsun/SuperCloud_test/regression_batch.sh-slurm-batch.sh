#!/bin/bash
#SBATCH --job-name=pytorch
#SBATCH --output=%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:volta:1

source /etc/profile
module load anaconda/2023a
module load cuda/11.6
module load nccl/2.11.4-cuda11.6
python regression_pytorch.py
