#!/bin/bash
#FLUX --job-name=frigid-poo-7335
#FLUX -N=2
#FLUX --gpus-per-task=1
#FLUX: --exclusive
#FLUX -t=300
#FLUX --urgency=16

export NCCL_DEBUG='INFO'

export NCCL_DEBUG=INFO
srun -u -l shifter python test_nccl.py
