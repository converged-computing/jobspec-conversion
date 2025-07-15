#!/bin/bash
#FLUX: --job-name=moolicious-peas-9928
#FLUX: --gpus-per-task=1
#FLUX: --exclusive
#FLUX: --priority=16

export NCCL_DEBUG='INFO'

export NCCL_DEBUG=INFO
srun -u -l shifter python test_nccl.py
