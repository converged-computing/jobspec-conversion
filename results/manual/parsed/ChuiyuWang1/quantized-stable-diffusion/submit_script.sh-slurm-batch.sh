#!/bin/bash
#SBATCH --output=ldm-%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=42
#SBATCH --gres=gpu:1
#SBATCH --time=03:00:00
#SBATCH --constraint=ntasks-per-node=1

module purge
module load pytorch/1.12.1
source activate ldm
cd latent-diffusion
CUDA_VISIBLE_DEVICES=0 python scripts/evaluation.py
