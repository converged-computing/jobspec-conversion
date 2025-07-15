#!/bin/bash
#FLUX: --job-name=crunchy-nunchucks-0156
#FLUX: -c=4
#FLUX: -t=10740
#FLUX: --priority=16

export CUBLAS_WORKSPACE_CONFIG=':16:8'

export CUBLAS_WORKSPACE_CONFIG=:16:8
module load httpproxy
source ../ENV/bin/activate
python src/main.py --configs 'configs/resnet20_cifar10.jsonnet, configs/quantization/4bit_wcat.jsonnet' train
