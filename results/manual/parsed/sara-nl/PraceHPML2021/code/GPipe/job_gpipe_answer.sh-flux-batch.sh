#!/bin/bash
#FLUX: --job-name=boopy-hope-2937
#FLUX: --priority=16

export PYTHONUNBUFFERED='1'

source ${TEACHER_DIR}/JHL_hooks/env
tar -C "$TMPDIR" -zxf ${TEACHER_DIR}/JHL_data/MNIST.tar.gz
export PYTHONUNBUFFERED=1
python mnist_gpipe_answer.py --arch resnet50 --datadir="$TMPDIR" --batchsize=512 --num_microbatches=6 --balance_by=time
