#!/bin/bash
#SBATCH --output=pytorch-%j.out
#SBATCH --error=pytorch-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=3
#SBATCH --gres=gtx1080ti:1
#SBATCH --time=00:03:00
#SBATCH --partition=gpu_shared_jupyter

export PYTHONUNBUFFERED='1'

module purge
source ${TEACHER_DIR}/JHL_hooks/env
tar -C "$TMPDIR" -zxf ${TEACHER_DIR}/JHL_data/MNIST.tar.gz
export PYTHONUNBUFFERED=1
python mnist_pytorch.py --arch resnet50 --datadir="$TMPDIR" --batchsize=256
