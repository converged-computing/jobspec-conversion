#!/bin/bash
#FLUX: --job-name=bricky-lizard-8824
#FLUX: --priority=16

module load cuda/75/blas/7.5.18
module load cuda/75/fft/7.5.18
module load cuda/75/nsight/7.5.18
module load cuda/75/profiler/7.5.18
module load cuda/75/toolkit/7.5.18
module load cudnn/6.0/cuda75
module load pytorch/1.0.1
CUDA_VISIBLE_DEVICES=0,1,2,3 python3 /home/xm0036/DNN/PyTorch/pytorch_cifar/cifar.py --netName=SEResNet18 --bs=512 --cifar=100
