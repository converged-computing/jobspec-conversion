#!/bin/bash
#FLUX: --job-name=gc-train
#FLUX: -t=604800
#FLUX: --priority=16

chmod +x ./scripts/prepare.sh
source ./scripts/prepare.sh
NCCL_DEBUG=TRACE NCCL_DEBUG_SUBSYS=ALL ACCELERATE_LOG_LEVEL=DEBUG torchrun --standalone --nnodes=1 --nproc_per_node=2 --rdzv_backend=c10d --rdzv_id=$SLURM_JOB_ID --module graph_coder.run --spawn --root "$1" "${@:2}"
