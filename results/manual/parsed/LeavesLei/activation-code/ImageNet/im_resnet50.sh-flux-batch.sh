#!/bin/bash
#FLUX: --job-name=stanky-signal-3630
#FLUX: -c=10
#FLUX: --priority=16

cd /public/data1/users/leishiye
source .bashrc
cd neural_code/activation-code/ImageNet
python imagenet_resnet50.py
