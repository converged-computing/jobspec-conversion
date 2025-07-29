#!/bin/bash
#FLUX: --job-name=fabrictraining
#FLUX: -N=2
#FLUX: -c=32
#FLUX: --queue=gilbreth-k
#FLUX: -t=7200
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'
export NCCL_SOCKET_IFNAME='ib'

mamba activate ml
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
export NCCL_SOCKET_IFNAME="ib"
module load cuda/12.1.0
srun python multnodetest.py
