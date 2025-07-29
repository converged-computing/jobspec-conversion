#!/bin/bash
#SBATCH --job-name=trainer
#SBATCH --output=trainer.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=80G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=rocky8

source ~/.bashrc
conda activate pytorch
python -u src/bioplnn/topography_trainer.py --config config/config_topography_random.yaml
