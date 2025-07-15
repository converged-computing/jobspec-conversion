#!/bin/bash
#FLUX: --job-name=expensive-lamp-6379
#FLUX: -c=10
#FLUX: --urgency=16

cd /public/data1/users/leishiye
source .bashrc
cd neural_code/activation-code/ImageNet
python imagenet_resnet50.py
