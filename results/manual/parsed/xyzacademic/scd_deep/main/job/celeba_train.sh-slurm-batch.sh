#!/bin/bash
#SBATCH --job-name=celeba_train
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --partition=datasci

cd ..
python train_lenet_.py --dataset celeba --seed 2018 --n_classes 2 \
--save --target celeba_resnet50_10.pkl --round 10
