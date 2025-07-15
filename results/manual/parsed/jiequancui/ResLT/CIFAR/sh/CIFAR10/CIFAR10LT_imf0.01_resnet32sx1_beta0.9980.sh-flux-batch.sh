#!/bin/bash
#FLUX: --job-name=CIFAR10V2
#FLUX: --priority=16

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
