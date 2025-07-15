#!/bin/bash
#FLUX: --job-name=carnivorous-bits-6821
#FLUX: -c=20
#FLUX: --urgency=16

export OMP_NUM_THREADS='20'
export IMAGENET_PATH='/home/gridsan/groups/datasets/ImageNet'

source /etc/profile
module load anaconda/2023a
export OMP_NUM_THREADS=20
export IMAGENET_PATH=/home/gridsan/groups/datasets/ImageNet
python main.py --train_bs 128 --test_bs 128 --arch resnet50 --dataset imagenet --epochs 500
