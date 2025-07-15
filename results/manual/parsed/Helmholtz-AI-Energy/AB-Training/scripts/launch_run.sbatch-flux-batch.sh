#!/bin/bash
#FLUX: --job-name=madonna
#FLUX: -N=4
#FLUX: --queue=accelerated
#FLUX: -t=18000
#FLUX: --priority=16

export EXT_DATA_PREFIX='/hkfs/home/dataset/datasets/'
export TOMOUNT='${TOMOUNT}'
export WANDB_API_KEY='4a4a69b3f101858c816995e6dfa553718fdf0dbe'
export CUDA_VISIBLE_DEVICES='0,1,2,3'
export UCX_MEMTYPE_CACHE='0'
export NCCL_IB_TIMEOUT='100'
export SHARP_COLL_LOG_LEVEL='3'
export OMPI_MCA_coll_hcoll_enable='0'
export NCCL_SOCKET_IFNAME='ib0'
export NCCL_COLLNET_ENABLE='0'
export CONFIG_NAME='configs/ab_train_cifar.yaml'

ml purge
BASE_DIR="/hkfs/work/workspace/scratch/qv2382-madonna-ddp/"
BASE_DIR="/hkfs/work/workspace/scratch/qv2382-madonna-ddp/"
export EXT_DATA_PREFIX="/hkfs/home/dataset/datasets/"
TOMOUNT='/etc/slurm/task_prolog:/etc/slurm/task_prolog,'
TOMOUNT+="${EXT_DATA_PREFIX},"
TOMOUNT+="${BASE_DIR},"
TOMOUNT+="/scratch,/tmp"
export TOMOUNT="${TOMOUNT}"
export WANDB_API_KEY="4a4a69b3f101858c816995e6dfa553718fdf0dbe"
SRUN_PARAMS=(
  --mpi="pmi2"
  # --gpus-per-task=4
  --cpus-per-task=8
  #--cpu-bind="ldoms"
  --gpu-bind="closest"
  --label
  --container-name=torch2.2.0
  --container-writable
  --container-mount-home
  --container-mounts="${TOMOUNT}"
)
export CUDA_VISIBLE_DEVICES="0,1,2,3"
export UCX_MEMTYPE_CACHE=0
export NCCL_IB_TIMEOUT=100
export SHARP_COLL_LOG_LEVEL=3
export OMPI_MCA_coll_hcoll_enable=0
export NCCL_SOCKET_IFNAME="ib0"
export NCCL_COLLNET_ENABLE=0
export CUDA_VISIBLE_DEVICES="0,1,2,3"
export CONFIG_NAME="patchwork_train.yaml"
export CONFIG_NAME="configs/ab_train_cifar.yaml"
srun "${SRUN_PARAMS[@]}" bash -c "cd ${BASE_DIR}madonna/; CONFIG_NAME=${CONFIG_NAME} python -u ${BASE_DIR}madonna/scripts/propulate_train.py"
