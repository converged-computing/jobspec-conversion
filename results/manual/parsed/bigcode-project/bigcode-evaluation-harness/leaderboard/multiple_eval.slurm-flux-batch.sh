#!/bin/bash
#FLUX: --job-name=lovely-arm-5278
#FLUX: -c=48
#FLUX: --queue=production-cluster
#FLUX: --urgency=16

export LAUNCHER='accelerate launch \'
export NCCL_ASYNC_ERROR_HANDLING='1'
export NCCL_PROTO='simple'
export RDMAV_FORK_SAFE='1'
export FI_EFA_FORK_SAFE='1'
export FI_EFA_USE_DEVICE_RDMA='1'
export FI_PROVIDER='efa'
export FI_LOG_LEVEL='1'
export NCCL_IB_DISABLE='1'
export NCCL_SOCKET_IFNAME='ens'

set -x -e
source /admin/home/loubna/.bashrc
conda activate brr4
echo "START TIME: $(date)"
GPUS_PER_NODE=4
MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
MASTER_PORT=6000
NNODES=$SLURM_NNODES
NODE_RANK=$SLURM_PROCID
WORLD_SIZE=$(($GPUS_PER_NODE*$NNODES))
model=$1
task=$2
org=$3
out_path=$4
CMD="\
    /fsx/loubna/code/bigcode-evaluation-harness/main.py \
    --model $org/$model \
    --tasks $task \
    --max_length_generation 512 \
    --batch_size 50 \
    --n_samples 50 \
    --temperature 0.2 \
    --precision bf16 \
    --allow_code_execution \
    --trust_remote_code \
    --save_generations \
    --use_auth_token \
    --generation_only \
    --save_generations_path $out_path/generations_$task\_$model.json \
"
export LAUNCHER="accelerate launch \
    --multi_gpu \
    --num_machines $NNODES \
    --num_processes $WORLD_SIZE \
    --main_process_ip "$MASTER_ADDR" \
    --main_process_port $MASTER_PORT \
    --num_processes $WORLD_SIZE \
    --machine_rank \$SLURM_PROCID \
    --role $SLURMD_NODENAME: \
    --rdzv_conf rdzv_backend=c10d \
    --max_restarts 0 \
    --tee 3 \
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
echo $CMD
SRUN_ARGS=" \
    --wait=60 \
    --kill-on-bad-exit=1 \
    "
clear; srun $SRUN_ARGS --jobid $SLURM_JOB_ID bash -c "$LAUNCHER $CMD"
echo "END TIME: $(date)"
