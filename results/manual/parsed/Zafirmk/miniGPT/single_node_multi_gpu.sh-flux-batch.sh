#!/bin/bash
#FLUX: --job-name=single_node_multi_gpu
#FLUX: -c=4
#FLUX: --gpus-per-task=4
#FLUX: -t=21600
#FLUX: --priority=16

export LOGLEVEL='INFO'
export TORCH_NCCL_BLOCKING_WAIT='1'
export TORCH_DISTRIBUTED_DEBUG='DETAIL'

module purge
module load cuda
module load python/3.11
module load arrow/15.0.1
source ~/projects/def-eugenium/zafirmk/miniGPT/testenv/bin/activate
echo "Starting Training..."
export LOGLEVEL=INFO
export TORCH_NCCL_BLOCKING_WAIT=1
export TORCH_DISTRIBUTED_DEBUG=DETAIL
srun ~/projects/def-eugenium/zafirmk/miniGPT/testenv/bin/torchrun \
 --standalone \
 --nproc_per_node=gpu \
 main.py
