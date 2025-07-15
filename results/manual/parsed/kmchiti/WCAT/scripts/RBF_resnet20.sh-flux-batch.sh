#!/bin/bash
#FLUX: --job-name=chunky-nunchucks-0681
#FLUX: -c=4
#FLUX: -t=3540
#FLUX: --priority=16

export CUBLAS_WORKSPACE_CONFIG=':16:8'

export CUBLAS_WORKSPACE_CONFIG=:16:8
module load httpproxy
source ../ENV/bin/activate
python src/main.py --configs 'configs/resnet20_cifar10.jsonnet, configs/quantization/4bit_wcat.jsonnet, configs/attack/random_flip.jsonnet' random_flip
