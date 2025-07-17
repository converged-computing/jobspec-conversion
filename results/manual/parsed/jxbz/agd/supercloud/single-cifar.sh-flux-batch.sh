#!/bin/bash
#FLUX: --job-name=hello-leopard-2259
#FLUX: -c=20
#FLUX: --urgency=16

export OMP_NUM_THREADS='20'
export IMAGENET_PATH='/home/gridsan/groups/datasets/ImageNet'

source /etc/profile
module load anaconda/2023a
export OMP_NUM_THREADS=20
export IMAGENET_PATH=/home/gridsan/groups/datasets/ImageNet
python main.py --train_bs 400 --test_bs 400 --arch resnet50 --dataset cifar10 --epochs 300 --loss xent
