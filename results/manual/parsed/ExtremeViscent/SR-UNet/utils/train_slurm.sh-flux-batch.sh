#!/bin/bash
#FLUX: --job-name=bunet
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

export MASTER_PORT='11451'
export WORLD_SIZE='8'
export NPROC_PER_NODE='4'
export RANK='$SLURM_PROCID'
export LOCAL_RANK='$SLURM_LOCALID'
export NNODES='$SLURM_JOB_NUM_NODES'
export NODE_RANK='$SLURM_NODEID'
export MASTER_ADDR='$master_addr'

export MASTER_PORT=11451
export WORLD_SIZE=8
export NPROC_PER_NODE=4
export RANK=$SLURM_PROCID
export LOCAL_RANK=$SLURM_LOCALID
export NNODES=$SLURM_JOB_NUM_NODES
export NODE_RANK=$SLURM_NODEID
echo "NODELIST="${SLURM_NODELIST}
master_addr=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_ADDR=$master_addr
echo "MASTER_ADDR="$MASTER_ADDR
source /users/k21113539/.bashrc
. "/users/k21113539/anaconda3/etc/profile.d/conda.sh"
conda activate cai
nvidia-smi
cd /scratch/users/k21113539/SR-UNet
torchrun --nnodes $NNODES --master_addr $MASTER_ADDR --master_port $MASTER_PORT --node_rank $NODE_RANK --nproc_per_node $NPROC_PER_NODE /scratch/users/k21113539/SR-UNet/train_vae_bottleneck.py --config /scratch/users/k21113539/SR-UNet/configs/CREATE/config_vae_dhcp_t1.py
