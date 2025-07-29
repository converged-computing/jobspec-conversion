#!/bin/bash
#SBATCH --job-name=xai_dev
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=10G
#SBATCH --array=1-1

source venv/bin/activate
python main.py --config configs/resnet18_binary_classification.yaml --verbose
