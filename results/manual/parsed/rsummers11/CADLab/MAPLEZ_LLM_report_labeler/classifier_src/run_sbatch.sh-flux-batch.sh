#!/bin/bash
#FLUX: --job-name=moolicious-eagle-8043
#FLUX: --queue=gpu
#FLUX: -t=345600
#FLUX: --urgency=16

. ./miniconda3/etc/profile.d/conda.sh
conda activate
conda activate mimic_classifier
torchrun --rdzv-backend=c10d --rdzv-endpoint=localhost:0 --nnodes=1 src/train_pytorch.py "$@"
