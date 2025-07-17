#!/bin/bash
#FLUX: --job-name=vep_embed
#FLUX: -t=345600
#FLUX: --urgency=16

export CUDA_LAUNCH_BLOCKING='1'
export CUBLAS_WORKSPACE_CONFIG=':4096:8  # Needed for setting deterministic functions for reproducibility'

NUM_WORKERS=2
NUM_DEVICES=8
cd ../ || exit  # Go to the root directory of the repo
source setup_env.sh
export CUDA_LAUNCH_BLOCKING=1
export CUBLAS_WORKSPACE_CONFIG=:4096:8  # Needed for setting deterministic functions for reproducibility
torchrun \
    --standalone \
    --nnodes=1 \
    --nproc-per-node=${NUM_DEVICES} \
    vep_embeddings.py \
      --num_workers=${NUM_WORKERS} \
      --seq_len=${seq_len}  \
      --bp_per_token=${bp_per_token}  \
      --embed_dump_batch_size=${embed_dump_batch_size} \
      --name="${name}"  \
      --model_name_or_path="${model_name_or_path}" \
      --"${rcps_flag}"
