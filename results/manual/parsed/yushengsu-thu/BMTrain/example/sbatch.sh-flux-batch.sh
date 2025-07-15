#!/bin/bash
#FLUX: --job-name=cpm2-test
#FLUX: --queue=rtx2080
#FLUX: --priority=16

MASTER_PORT=30123
MASTER_HOST=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
srun torchrun --nnodes=$SLURM_JOB_NUM_NODES --nproc_per_node=$SLURM_GPUS_PER_NODE --rdzv_id=$SLURM_JOB_ID --rdzv_backend=c10d --rdzv_endpoint=$MASTER_HOST:$MASTER_PORT train.py
