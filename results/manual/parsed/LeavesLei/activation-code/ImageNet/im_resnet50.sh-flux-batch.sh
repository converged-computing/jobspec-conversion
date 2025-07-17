#!/bin/bash
#FLUX: --job-name=resnet_im
#FLUX: -c=10
#FLUX: --queue=nips
#FLUX: -t=72000
#FLUX: --urgency=16

cd /public/data1/users/leishiye
source .bashrc
cd neural_code/activation-code/ImageNet
python imagenet_resnet50.py
