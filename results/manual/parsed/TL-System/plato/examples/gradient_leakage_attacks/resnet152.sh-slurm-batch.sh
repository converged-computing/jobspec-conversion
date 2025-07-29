#!/bin/bash
#SBATCH --output=resnet152.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu:1
#SBATCH --mem=72G
#SBATCH --time=10:00:00

./../../run -c fedavg_resnet152_cifar100.yml
