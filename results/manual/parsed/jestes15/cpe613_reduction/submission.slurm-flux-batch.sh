#!/bin/bash
#FLUX --job-name=nerdy-latke-7843
#FLUX -c=16
#FLUX --gpus-per-task=1
#FLUX --queue=gpu
#FLUX --urgency=16

lspci -vvv |& grep "NVIDIA" |& tee slurm-lspci.out
make A100 && \
  ./main_a100
