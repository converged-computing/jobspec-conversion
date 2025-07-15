#!/bin/bash
#FLUX: --job-name=lightning_test
#FLUX: -N=2
#FLUX: -c=10
#FLUX: -t=3600
#FLUX: --priority=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'
export NCCL_SOCKET_IFNAME='^docker0,lo'
export MASTER_PORT='$((12000 + RANDOM % 20000))$'

source activate YourEnv
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
export NCCL_SOCKET_IFNAME=^docker0,lo
module load NCCL/2.4.7-1-cuda.10.0
export MASTER_PORT=$((12000 + RANDOM % 20000))$
srun python multi_node_own_slurm_script.py
