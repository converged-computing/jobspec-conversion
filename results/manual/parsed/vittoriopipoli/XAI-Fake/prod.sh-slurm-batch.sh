#!/bin/bash
#SBATCH --job-name=ResNet18_FS_BW
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:06:00
#SBATCH --partition=prod
#SBATCH --array=1-1

source venv/bin/activate
python main.py --config configs/resnet18_binary_classification.yaml --verbose
