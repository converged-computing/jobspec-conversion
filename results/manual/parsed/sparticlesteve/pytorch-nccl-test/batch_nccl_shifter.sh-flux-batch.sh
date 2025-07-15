#!/bin/bash
#FLUX: --job-name=gloopy-peanut-9842
#FLUX: --gpus-per-task=1
#FLUX: --exclusive
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'

export NCCL_DEBUG=INFO
srun -u -l shifter python test_nccl.py
