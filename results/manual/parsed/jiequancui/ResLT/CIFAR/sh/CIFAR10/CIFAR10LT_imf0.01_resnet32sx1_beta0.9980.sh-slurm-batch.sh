#!/bin/bash
#SBATCH --job-name=CIFAR10V2
#SBATCH --output=CIFAR100V2_imf0.02_res32x1_beta0.994.log
#SBATCH --mail-user=jqcui@cse.cuhk.edu.hk
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1

python cifarTrain_reslt_cifar10.py \
  -mark CIFAR10V2_imf0.01_res32x1_beta0.9980 \
  --arch ResLTResNet32 \
  --scale 1 \
  --lr 0.1 \
  --weight-decay 5e-4 \
  -dataset CIFAR10V2 \
  --imb_factor 0.01 \
  -num_classes 10 \
  -b 128 \
  --epochs 200 \
  --beta 0.9980
