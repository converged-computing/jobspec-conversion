#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --constraint=ntasks-per-node=1

module load tensorflow/1.13.1-py36-gpu
cd gcn && python3 train.py --save $@
