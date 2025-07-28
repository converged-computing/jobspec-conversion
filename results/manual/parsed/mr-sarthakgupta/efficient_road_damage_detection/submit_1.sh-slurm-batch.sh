#!/bin/bash
#FLUX: --job-name=job1
#FLUX: --queue=dgx
#FLUX: -t=86400
#FLUX: --urgency=16

CUDA_HOME=/usr/local/cuda
CUDA_VISIBLE_DEVICES=1
PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
nvcc --version
nvidia-smi
python kd.py
