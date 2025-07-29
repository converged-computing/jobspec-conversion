#!/bin/bash
#SBATCH --job-name=sanity_simclr_single_train
#SBATCH --output=singlenode-%j.out
#SBATCH --error=singlenode-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:4
#SBATCH --mem=0
#SBATCH --time=04:00:00
#SBATCH --qos=m2
#SBATCH --constraint=ntasks-per-node=4

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
