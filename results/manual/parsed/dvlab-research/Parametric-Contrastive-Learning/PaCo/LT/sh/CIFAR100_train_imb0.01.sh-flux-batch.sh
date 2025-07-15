#!/bin/bash
#FLUX: --job-name=cifar100-r32
#FLUX: --priority=16

PORT=$[$RANDOM + 10000]
python paco_cifar.py \
  --dataset cifar100 \
  --arch resnet32 \
  --imb-factor 0.01 \
  --alpha 0.01 \
  --beta 1.0 \
  --gamma 1.0 \
  --wd 5e-4 \
  --mark CIFAR100_imb001_R32_001_005_t3 \
  --lr 0.05 \
  --moco-t 0.05 \
  --moco-k 1024 \
  --moco-dim 32 \
  --feat_dim 64 \
  --aug cifar100 \
  --dist-url "tcp://localhost:$PORT" \
  --epochs 400
