#!/bin/bash
#FLUX: --job-name=cowy-lemur-1551
#FLUX: --queue=# set partition name
#FLUX: --priority=16

TORCH_DISTRIBUTED_DEBUG=INFO
singularity exec --pwd $(pwd) --nv \
  -B /myovision:/mnt \
  image \
  bash -c "cd /mnt/myovision-sam && torchrun --standalone --nproc_per_node=gpu train.py"
