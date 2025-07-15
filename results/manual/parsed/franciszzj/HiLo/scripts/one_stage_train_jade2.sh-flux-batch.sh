#!/bin/bash
#FLUX: --job-name=openpsg
#FLUX: -c=5
#FLUX: -t=86400
#FLUX: --urgency=16

export PYTORCH_CUDA_ALLOC_CONF='max_split_size_mb:128'

source ~/.bashrc
module load cuda
nvidia-smi -i $CUDA_VISIBLE_DEVICES
nvcc --version
CONFIG=$1
GPUS=8
PORT=$(shuf -i 10000-65535 -n 1)
export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:128
PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
EVAL_PAN_RELS=False \
WANDB_MODE="offline" \
python -m torch.distributed.launch \
  --nproc_per_node=$GPUS \
  --master_port=$PORT \
  tools/train.py \
  $CONFIG \
  --auto-resume \
  --no-validate \
  --seed 666 \
  --launcher pytorch
