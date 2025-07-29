#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=16

python3 train_operator.py --config_path configs/operator/Re500-FNO.yaml
