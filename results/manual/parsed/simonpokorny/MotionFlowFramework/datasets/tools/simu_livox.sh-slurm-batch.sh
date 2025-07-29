#!/bin/bash
#SBATCH --output=logs/%j.out
#SBATCH --error=logs/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=60G
#SBATCH --time=04:00:00
#SBATCH --partition=amdgpufast
#SBATCH --constraint=ntasks-per-node=2

ml torchsparse
cd $HOME
python -u data_utils/livox/simu_livox.py
