#!/bin/bash
#FLUX: --job-name=tutorial
#FLUX: -t=3600
#FLUX: --urgency=16

export MASTER_ADDR='$master_addr'
export MASTER_PORT='13579'
export NCCL_SOCKET_IFNAME='^docker0,lo'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/central/groups/mthomson/zam/miniconda3/lib'
export TORCH_HOME='/groups/mthomson/zam/.cache/torch/hub/checkpoints'

module purge
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
export MASTER_PORT=13579
export NCCL_SOCKET_IFNAME=^docker0,lo
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/central/groups/mthomson/zam/miniconda3/lib
export TORCH_HOME=/groups/mthomson/zam/.cache/torch/hub/checkpoints
source ~/.bashrc
srun python3 newmain.py tutorial ../data/query.fasta 4 --epochs 5 --strategy fsdp
