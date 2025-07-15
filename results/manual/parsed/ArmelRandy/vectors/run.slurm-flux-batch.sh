#!/bin/bash
#FLUX: --job-name=vectors
#FLUX: -c=96
#FLUX: --exclusive
#FLUX: --queue=production-cluster
#FLUX: --priority=16

export WANDB_PROJECT='test'
export HF_DATASETS_CACHE='/fsx/armel/.cache'
export LAUNCHER='python \'
export NCCL_ASYNC_ERROR_HANDLING='1'
export NCCL_PROTO='simple'
export RDMAV_FORK_SAFE='1'
export FI_EFA_FORK_SAFE='1'
export FI_EFA_USE_DEVICE_RDMA='1'
export FI_PROVIDER='efa'
export FI_LOG_LEVEL='1'
export NCCL_IB_DISABLE='1'
export NCCL_SOCKET_IFNAME='ens'
export CUDA_HOME='/usr/local/cuda-11.6'
export LD_PRELOAD='$CUDA_HOME/lib/libnccl.so'
export LD_LIBRARY_PATH='$CUDA_HOME/efa/lib:$CUDA_HOME/lib:$CUDA_HOME/lib64:$LD_LIBRARY_PATH'

set -x -e
source /admin/home/armel/.bashrc
conda activate finetune
echo "START TIME: $(date)"
GPUS_PER_NODE=8
MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
MASTER_PORT=6000
NNODES=$SLURM_NNODES
NODE_RANK=$SLURM_PROCID 
WORLD_SIZE=$(($GPUS_PER_NODE*$NNODES))
export WANDB_PROJECT=test
export HF_DATASETS_CACHE="/fsx/armel/.cache"
PATH_TO_LOG=/fsx/armel/vectors/logs
LOG_PATH=$PATH_TO_LOG/log.txt
CMD="\
    ranks_all.py \
"
export LAUNCHER="python \
"
export NCCL_ASYNC_ERROR_HANDLING=1
export NCCL_PROTO=simple
export RDMAV_FORK_SAFE=1
export FI_EFA_FORK_SAFE=1
export FI_EFA_USE_DEVICE_RDMA=1
export FI_PROVIDER=efa
export FI_LOG_LEVEL=1
export NCCL_IB_DISABLE=1
export NCCL_SOCKET_IFNAME=ens
export CUDA_HOME=/usr/local/cuda-11.6
export LD_PRELOAD=$CUDA_HOME/lib/libnccl.so
export LD_LIBRARY_PATH=$CUDA_HOME/efa/lib:$CUDA_HOME/lib:$CUDA_HOME/lib64:$LD_LIBRARY_PATH
SRUN_ARGS=" \
    --wait=60 \
    --kill-on-bad-exit=1 \
    "
clear; srun $SRUN_ARGS --jobid $SLURM_JOB_ID bash -c "$LAUNCHER $CMD"
echo "END TIME: $(date)"
