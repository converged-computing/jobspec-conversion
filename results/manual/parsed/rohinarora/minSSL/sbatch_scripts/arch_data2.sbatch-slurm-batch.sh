#!/bin/bash
#SBATCH --job-name=arch_data2
#SBATCH --output=xepoch.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=50Gb
#SBATCH --time=1-00:00:00
#SBATCH --partition=ce-mri

source activate simclr1
python pre_train.py --dataset-name cifar10  --arch resnet50 --comment "_cifar10_resnet50"
