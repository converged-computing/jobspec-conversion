#!/bin/bash
#FLUX: --job-name=chunky-despacito-8897
#FLUX: -t=345600
#FLUX: --urgency=16

chmod +x src/learn.py
CUDA_VISIBLE_DEVICES=$(nvidia-smi --query-gpu=memory.free --format=csv,nounits,noheader | nl -v 0 | sort -nrk 2 | cut -f 1 | head -n 1 | xargs)\
python3 src/learn.py\
 --log-dir='logs/cifar100-resnet20' --exp-name="126ep_[5e-3_0.1]" --procedure='pretrain'\
 --epochs=126 --minlr=5e-3 --maxlr=0.1\
 --dataset='cifar100' --model='resnet20' --num-classes=100 --validsplit=0
