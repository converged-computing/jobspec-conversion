#!/bin/bash
#SBATCH --output=logs/train_flow_%j.out
#SBATCH --error=logs/train_flow_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=60G
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=2

ml torchsparse
cd $HOME
python -u motion_supervision/train.py
