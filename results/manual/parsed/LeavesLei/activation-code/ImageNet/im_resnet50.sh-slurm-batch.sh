#!/bin/bash
#SBATCH --job-name=resnet_im
#SBATCH --account=test
#SBATCH --output=resnet_im.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:1
#SBATCH --time=20:00:00
#SBATCH --partition=nips
#SBATCH --constraint=ntasks-per-node=1

cd /public/data1/users/leishiye
source .bashrc
cd neural_code/activation-code/ImageNet
python imagenet_resnet50.py
