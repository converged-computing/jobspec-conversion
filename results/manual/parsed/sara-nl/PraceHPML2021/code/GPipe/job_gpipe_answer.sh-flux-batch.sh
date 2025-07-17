#!/bin/bash
#FLUX: --job-name=carnivorous-blackbean-1850
#FLUX: -c=6
#FLUX: --queue=gpu_shared_jupyter
#FLUX: -t=180
#FLUX: --urgency=16

export PYTHONUNBUFFERED='1'

source ${TEACHER_DIR}/JHL_hooks/env
tar -C "$TMPDIR" -zxf ${TEACHER_DIR}/JHL_data/MNIST.tar.gz
export PYTHONUNBUFFERED=1
python mnist_gpipe_answer.py --arch resnet50 --datadir="$TMPDIR" --batchsize=512 --num_microbatches=6 --balance_by=time
