#!/bin/bash
#SBATCH --job-name=lab2
#SBATCH --account=coms030144
#SBATCH --output=./log_%j.out
#SBATCH --error=./log_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4GB
#SBATCH --time=00:20:00

module purge
module load "languages/anaconda3/2021-3.8.8-cuda-11.1-pytorch"
python train_cifar.py
