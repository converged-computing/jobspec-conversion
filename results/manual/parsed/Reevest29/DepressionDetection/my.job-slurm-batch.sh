#!/bin/bash
#SBATCH --account=msoleyma_1026
#SBATCH --output=logs/DepressionDetection-cv-2-balanced
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=32GB
#SBATCH --time=2-00:00:00

eval "$(conda shell.bash hook)"
conda activate mm
cd /home1/tereeves/mm/DepressionDetection
python train.py
