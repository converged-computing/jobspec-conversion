#!/bin/bash
#FLUX: --job-name=mosaicml-stable-diffusion
#FLUX: -N=2
#FLUX: -c=16
#FLUX: --exclusive
#FLUX: --urgency=16

export FI_EFA_USE_DEVICE_RDMA='1 # use for p4d'
export FI_EFA_FORK_SAFE='1'
export FI_LOG_LEVEL='1'
export FI_PROVIDER='efa # change to eth if you want to use ENA for comparisons'
export FI_EFA_ENABLE_SHM_TRANSFER='1'
export NCCL_DEBUG='INFO'
export WANDB_MODE='offline'
export LD_LIBRARY_PATH='/usr/local/lib/:$LD_LIBRARY_PATH'

: "${APPS_PATH:=/apps}"
: "${DATA_PATH:=/fsx}"
: "${IMAGE:=$APPS_PATH/mosaicml-stable-diffusion.sqsh}"
: "${FSX_MOUNT:=$DATA_PATH:$DATA_PATH}"
export FI_EFA_USE_DEVICE_RDMA=1 # use for p4d
export FI_EFA_FORK_SAFE=1
export FI_LOG_LEVEL=1
export FI_PROVIDER=efa # change to eth if you want to use ENA for comparisons
export FI_EFA_ENABLE_SHM_TRANSFER=1
export NCCL_DEBUG=INFO
export WANDB_MODE=offline
declare -a ARGS=(
    --container-image $IMAGE
    --container-mounts $FSX_MOUNT
)
nodes=( $( scontrol show hostnames $SLURM_JOB_NODELIST ) )
nodes_array=($nodes)
head_node=${nodes_array[0]}
head_node_ip=$(srun --nodes=1 --ntasks=1 -w "$head_node" hostname --ip-address)
echo Node IP: $head_node_ip
export LD_LIBRARY_PATH=/usr/local/lib/:$LD_LIBRARY_PATH
srun -l "${ARGS[@]}" python3 benchmark_distributed.py
