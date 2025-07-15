#!/bin/bash
#FLUX: --job-name=raw
#FLUX: -N=24
#FLUX: -c=16
#FLUX: -t=21600
#FLUX: --urgency=16

export GPUS_PER_NODE='6'
export MASTER_ADDR='$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)'
export MASTER_PORT='8000'
export WANDB_MODE='disabled'
export LOGLEVEL='INFO'
export NCCL_DEBUG='INFO'
export NCCL_BLOCKING_WAIT='1'
export TORCH_DISTRIBUTED_DETAIL='DEBUG'

source ~/.bashrc_bk
eval "$(conda shell.bash hook)"
conda activate ego
export GPUS_PER_NODE=6
export MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
export MASTER_PORT=8000
export WANDB_MODE=disabled
echo "GPUS_PER_NODE: $GPUS_PER_NODE"
echo "SLURM_NNODES: $SLURM_NNODES"
echo "SLURM_NODEID: $SLURM_NODEID"
echo "MASTER_ADDR: $MASTER_ADDR"
echo "MASTER_PORT: $MASTER_PORT"
export LOGLEVEL=INFO
export NCCL_DEBUG=INFO
export NCCL_BLOCKING_WAIT=1
export TORCH_DISTRIBUTED_DETAIL=DEBUG
srun bash -c 'torchrun \
    --nproc_per_node $GPUS_PER_NODE \
    --nnodes $SLURM_NNODES \
    --node_rank $SLURM_PROCID \
    --master_addr $MASTER_ADDR \
    --master_port $MASTER_PORT \
    train_rtx.py \
    --batch_size 2 \
    --lr 7e-5 \
    --save_id 1 \
    --image_size 64 \
    --H 8 \
    --job_name raw'
