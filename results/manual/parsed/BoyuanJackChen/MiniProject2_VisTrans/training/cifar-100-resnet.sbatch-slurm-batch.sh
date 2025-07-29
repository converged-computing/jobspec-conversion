#!/bin/bash
#SBATCH --job-name=cifar-100-resnet
#SBATCH --output=cifar-100-resnet.out
#SBATCH --nodes=3
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=10GB
#SBATCH --time=03:00:00
#SBATCH --constraint=ntasks-per-node=2

python3 main.py --model="res18" --dataset="CIFAR-100" --epochs=2000 --checkpoint=100
