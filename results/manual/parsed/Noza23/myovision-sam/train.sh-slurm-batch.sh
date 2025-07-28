#!/bin/bash
#FLUX: --job-name=multi-gpu-training
#FLUX: --queue=
#FLUX: --urgency=16

TORCH_DISTRIBUTED_DEBUG=INFO
singularity exec --pwd $(pwd) --nv \
  -B /myovision:/mnt \
  image \
  bash -c "cd /mnt/myovision-sam && torchrun --standalone --nproc_per_node=gpu train.py"
