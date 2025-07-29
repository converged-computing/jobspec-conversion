#!/bin/bash
#SBATCH --job-name=trainer
#SBATCH --output=trainer.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=10G
#SBATCH --time=08:00:00
#SBATCH --constraint=rocky8

source ~/.bashrc
conda activate pytorch
python -u src/price_predictor/train.py --config config.yaml
