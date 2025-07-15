#!/bin/bash
#FLUX: --job-name="sanity_simclr_single_train"
#FLUX: -c=8
#FLUX: -t=14400
#FLUX: --priority=16

export NCCL_IB_DISABLE='1  # Our cluster does not have InfiniBand. We need to disable usage using this flag.'
export TORCH_NCCL_ASYNC_ERROR_HANDLING='1 # set to 1 for NCCL backend'
export PYTHONPATH='.'

source /ssd003/projects/aieng/envs/genssl3/bin/activate
export NCCL_IB_DISABLE=1  # Our cluster does not have InfiniBand. We need to disable usage using this flag.
export TORCH_NCCL_ASYNC_ERROR_HANDLING=1 # set to 1 for NCCL backend
export PYTHONPATH="."
nvidia-smi
torchrun --nproc-per-node=4 --nnodes=1 solo-learn/main_pretrain.py \
    --config-path scripts/pretrain/imagenet/ \
    --config-name simclr.yaml
