#!/bin/bash
#FLUX: --job-name=cifar-100-resnet
#FLUX: -N=3
#FLUX: -t=10800
#FLUX: --urgency=16

python3 main.py --model="res18" --dataset="CIFAR-100" --epochs=2000 --checkpoint=100
