#!/bin/bash
#FLUX: --job-name=megatron_gpt
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --urgency=16

export FI_EFA_USE_DEVICE_RDMA='1 # use for p4d'
export FI_PROVIDER='efa # change to eth if you want to use ENA for comparisons'
export FI_EFA_FORK_SAFE='1'
export FI_LOG_LEVEL='1'
export FI_EFA_ENABLE_SHM_TRANSFER='1'
export NCCL_ASYNC_ERROR_HANDLING='1'
export NCCL_DEBUG='INFO'

: "${APPS_PATH:=/apps}"
: "${NCCL_TESTS_PATH:=/opt/nccl-tests/build}"
: "${DATA_PATH:=/fsx}"
: "${FSX_MOUNT:=$DATA_PATH:$DATA_PATH}"
: "${IMAGE:=$APPS_PATH/nccl.sqsh}"
export FI_EFA_USE_DEVICE_RDMA=1 # use for p4d
export FI_PROVIDER=efa
export FI_EFA_FORK_SAFE=1
export FI_LOG_LEVEL=1
export FI_PROVIDER=efa # change to eth if you want to use ENA for comparisons
export FI_EFA_ENABLE_SHM_TRANSFER=1
export NCCL_ASYNC_ERROR_HANDLING=1
export NCCL_DEBUG=INFO
declare -a ARGS=(
    --container-image $IMAGE
    --container-mount-home
    --container-mounts $FSX_MOUNT
    --no-container-remap-root
)
srun -l "${ARGS[@]}" --mpi=pmix /fsx/nccl-slurm-exec $NCCL_TESTS_PATH/scatter_perf -b 8 -e 2G -f 2 -g 1 -c 1 -n 100
