#!/bin/bash
#FLUX: --job-name=ddp-torch
#FLUX: -N=2
#FLUX: -c=8
#FLUX: -t=60
#FLUX: --urgency=16

export MASTER_PORT='$(get_free_port)'
export WORLD_SIZE='$(($SLURM_NNODES * $SLURM_NTASKS_PER_NODE))'
export MASTER_ADDR='$master_addr'

export MASTER_PORT=$(get_free_port)
export WORLD_SIZE=$(($SLURM_NNODES * $SLURM_NTASKS_PER_NODE))
echo "WORLD_SIZE="$WORLD_SIZE
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
echo "MASTER_ADDR="$MASTER_ADDR
module purge
module load anaconda3/2023.9
conda activate torch-env
srun python simple_dpp.py
