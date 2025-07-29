#!/bin/bash
#SBATCH --job-name=data
#SBATCH --account=students
#SBATCH --output=job.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu
#SBATCH --time=06:00:00
#SBATCH --partition=brown

echo "Running on $(hostname):"
nvidia-smi
hostname
poetry run python src/train.py -M alexnet --wandb-name alexnet --wandb-tags hpc,image --device cuda --wandb-log
poetry run python src/train.py -M googlenet --wandb-name googlenet --wandb-tags hpc,image --device cuda --wandb-log
poetry run python src/train.py -M resnet18 --wandb-name resnet18 --wandb-tags hpc,image --device cuda --wandb-log
poetry run python src/train.py -M resnet50 --wandb-name resnet50 --wandb-tags hpc,image --device cuda --wandb-log
poetry run python src/train.py -M densenet121 --wandb-name densenet121 --wandb-tags hpc,image --device cuda --wandb-log
poetry run python src/train.py -M mobilenet_v3_small --wandb-name mobilenet_v3_small --wandb-tags hpc,image --device cuda --wandb-log
poetry run python src/train.py -M vit_b_16 --wandb-name vit_b_16 --wandb-tags hpc,image --device cuda --wandb-log
poetry run python src/train.py -M efficientnet_v2_s --wandb-name efficientnet_v2_s --wandb-tags hpc,image --device cuda --wandb-log
poetry run python src/train.py -M convnext_tiny --wandb-name convnext_tiny --wandb-tags hpc,image --device cuda --wandb-log
poetry run python src/train.py -M r2plus1d_18 --wandb-name r2plus1d_18 --wandb-tags hpc,video --device cuda --wandb-log
poetry run python src/train.py -M x3d_s --wandb-name x3d_s --wandb-tags hpc,video --device cuda --wandb-log
poetry run python src/train.py -M slow_r50 --wandb-name slow_r50 --wandb-tags hpc,video --device cuda --wandb-log
poetry run python src/train.py -M slowfast_r50 --wandb-name slowfast_r50 --wandb-tags hpc,video --device cuda --wandb-log
