#!/bin/bash
#FLUX: --job-name=ryan
#FLUX: --queue=a100-cu117
#FLUX: -t=1209600
#FLUX: --urgency=16

export TRANSFORMERS_CACHE='/mnt/nvme/home/ryan01/.cache/huggingface/transformers'
export HF_DATASETS_CACHE='/mnt/nvme/home/ryan01/.cache/huggingface/datasets'
export TORCH_HOME='/mnt/nvme/home/ryan01/.cache/torch'
export 'PYTORCH_CUDA_ALLOC_CONF='max_split_size_mb:512'
export OMP_NUM_THREADS='1'
export GPUS_PER_NODE='8'
export MASTER_ADDR='$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)'
export MASTER_PORT='9901'

source /mnt/nvme/home/ryan01/miniconda3/bin/activate eleuther
export TRANSFORMERS_CACHE="/mnt/nvme/home/ryan01/.cache/huggingface/transformers"
export HF_DATASETS_CACHE="/mnt/nvme/home/ryan01/.cache/huggingface/datasets"
export TORCH_HOME="/mnt/nvme/home/ryan01/.cache/torch"
export 'PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:512'
export OMP_NUM_THREADS=1
export GPUS_PER_NODE=8
export MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
export MASTER_PORT=9901
cd /mnt/nvme/ryan01/Anh/ahn/training
srun --jobid $SLURM_JOBID bash -c 'CUDA_LAUNCH_BLOCKING=1 torchrun \
--nproc_per_node=$GPUS_PER_NODE --nnodes=$SLURM_NNODES --node_rank=$SLURM_PROCID \
--master_addr $MASTER_ADDR --master_port $MASTER_PORT \
train_zero.py -c configs/xglm-train-zero.yaml'
