#!/bin/bash
#FLUX: --job-name=scruptious-butter-5597
#FLUX: -c=16
#FLUX: --gpus-per-task=1
#FLUX: --urgency=16

lspci -vvv |& grep "NVIDIA" |& tee slurm-lspci.out
make A100 && \
  ./main_a100
