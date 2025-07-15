#!/bin/bash
#FLUX: --job-name=fugly-gato-4403
#FLUX: --priority=16

export PYTHONUNBUFFERED='1'

module purge
source ${TEACHER_DIR}/JHL_hooks/env
tar -C "$TMPDIR" -zxf ${TEACHER_DIR}/JHL_data/MNIST.tar.gz
export PYTHONUNBUFFERED=1
python mnist_pytorch.py --arch resnet50 --datadir="$TMPDIR" --batchsize=256
