#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00
#SBATCH --partition=cuda-gpu

nvidia-smi
echo "Running PROTOMAML on Omniglot"
echo "--------------------------------------------------------------------------"
echo "20-way, 5-shot"
echo "--------------------------------------------------------------------------"
python3 protomaml.py --K_shot 5 --N_way 20 --image_background "images_background" --image_evaluation "images_evaluation" --epochs 400
