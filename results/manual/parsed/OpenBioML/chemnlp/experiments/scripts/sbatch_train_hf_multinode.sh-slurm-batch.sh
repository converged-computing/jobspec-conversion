#!/bin/bash
#FLUX: --job-name=llchem-multinode
#FLUX: -N=4
#FLUX: -c=12
#FLUX: --exclusive
#FLUX: --queue=g40x
#FLUX: --urgency=16

export TOKENIZERS_PARALLELISM='false'
export WANDB_BASE_URL='https://stability.wandb.io'
export NCCL_DEBUG='INFO'
export NCCL_ASYNC_ERROR_HANDLING='1'
export LOGLEVEL='INFO'

set -ex # allow for exiting based on non-0 codes
export TOKENIZERS_PARALLELISM=false
export WANDB_BASE_URL="https://stability.wandb.io"
export NCCL_DEBUG=INFO
export NCCL_ASYNC_ERROR_HANDLING=1
export LOGLEVEL=INFO
overrides=${4:-'{}'}
CHEMNLP_PATH=/fsx/proj-chemnlp/$2/chemnlp
source $CHEMNLP_PATH/experiments/scripts/env_creation_hf.sh $1 $2
nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIST ) )
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)
echo Node IP: $head_node_ip
srun torchrun --nnodes $SLURM_NNODES --nproc_per_node 8 \
--rdzv_id $RANDOM \
--rdzv_backend c10d \
--rdzv_endpoint $head_node_ip:29500 \
experiments/scripts/run_tune.py  experiments/configs/hugging-face/$3 --config_overrides $overrides
