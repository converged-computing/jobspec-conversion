#!/bin/bash
#FLUX: --job-name=salted-citrus-7749
#FLUX: -c=16
#FLUX: --gpus-per-task=1
#FLUX: --priority=16

lspci -vvv |& grep "NVIDIA" |& tee slurm-lspci.out
make A100 && \
  ./main_a100
