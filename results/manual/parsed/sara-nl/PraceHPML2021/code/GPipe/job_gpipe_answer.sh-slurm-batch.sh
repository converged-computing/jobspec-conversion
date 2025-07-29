#!/bin/bash
#SBATCH --output=gpipe-answer-%j.out
#SBATCH --error=gpipe-answer-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gtx1080ti:2
#SBATCH --time=00:03:00

export PYTHONUNBUFFERED='1'

source ${TEACHER_DIR}/JHL_hooks/env
tar -C "$TMPDIR" -zxf ${TEACHER_DIR}/JHL_data/MNIST.tar.gz
export PYTHONUNBUFFERED=1
python mnist_gpipe_answer.py --arch resnet50 --datadir="$TMPDIR" --batchsize=512 --num_microbatches=6 --balance_by=time
