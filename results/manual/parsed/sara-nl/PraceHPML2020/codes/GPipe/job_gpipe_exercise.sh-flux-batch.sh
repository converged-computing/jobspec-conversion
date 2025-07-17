#!/bin/bash
#FLUX: --job-name=doopy-car-3979
#FLUX: -c=6
#FLUX: --queue=gpu_shared
#FLUX: -t=180
#FLUX: --urgency=16

export PYTHONUNBUFFERED='1'

module purge
module load 2019
module load Python/3.6.6-foss-2019b
TEACHER_DIR=/home/ptc0000/
source ${TEACHER_DIR}/JHL_hooks/env
tar -C "$TMPDIR" -zxf ${TEACHER_DIR}/JHL_data/MNIST.tar.gz
export PYTHONUNBUFFERED=1
python ~/JHL_notebooks/GPipe/mnist_gpipe_exercise.py --arch resnet50 --datadir="$TMPDIR" --batchsize=512 --num_microbatches=6 --balance_by=time
