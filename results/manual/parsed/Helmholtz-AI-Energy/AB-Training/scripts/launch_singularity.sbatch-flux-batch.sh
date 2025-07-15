#!/bin/bash
#FLUX: --job-name=lovely-motorcycle-8837
#FLUX: --queue=accelerated
#FLUX: -t=28800
#FLUX: --priority=16

export TRAIN_SCRIPT='scripts/singularity_train.py'
export TOMOUNT='${TOMOUNT}'
export UCX_MEMTYPE_CACHE='0'
export NCCL_IB_TIMEOUT='100'
export SHARP_COLL_LOG_LEVEL='3'
export OMPI_MCA_coll_hcoll_enable='0'
export NCCL_SOCKET_IFNAME='ib0'
export NCCL_COLLNET_ENABLE='0'
export CUDA_VISIBLE_DEVICES='0,1,2,3'
export WANDB_API_KEY='4a4a69b3f101858c816995e6dfa553718fdf0dbe'
export MADONNA='/hkfs/work/workspace/scratch/qv2382-madonna-ddp/madonna'
export VENV_NAME='/hkfs/work/workspace/scratch/qv2382-madonna-ddp/containers/test_env'
export SINGULARITY_FILE='/hkfs/work/workspace/scratch/qv2382-madonna-ddp/containers/torch_new.sif'

export TRAIN_SCRIPT="scripts/singularity_train.py"
ml purge
BASE_DIR="/hkfs/work/workspace/scratch/qv2382-madonna-ddp/"
TOMOUNT='/etc/slurm/task_prolog.hk:/etc/slurm/task_prolog.hk,'
TOMOUNT+="${BASE_DIR},"
TOMOUNT+="/hkfs/home/dataset/datasets/,"
export TOMOUNT="${TOMOUNT}"
SRUN_PARAMS=(
  --mpi="pmix"
  --gpus-per-task=1
  # --cpus-per-task=8
  #--cpu-bind="ldoms"
  --gpu-bind="closest"
  --label
)
SCRIPT_DIR="/pfs/work7/workspace/scratch/qv2382-madonna-ddp/qv2382-madonna-ddp/madonna"
export UCX_MEMTYPE_CACHE=0
export NCCL_IB_TIMEOUT=100
export SHARP_COLL_LOG_LEVEL=3
export OMPI_MCA_coll_hcoll_enable=0
export NCCL_SOCKET_IFNAME="ib0"
export NCCL_COLLNET_ENABLE=0
export CUDA_VISIBLE_DEVICES="0,1,2,3"
export WANDB_API_KEY="4a4a69b3f101858c816995e6dfa553718fdf0dbe"
export MADONNA="/hkfs/work/workspace/scratch/qv2382-madonna-ddp/madonna"
export VENV_NAME="/hkfs/work/workspace/scratch/qv2382-madonna-ddp/containers/test_env"
export SINGULARITY_FILE="/hkfs/work/workspace/scratch/qv2382-madonna-ddp/containers/torch_new.sif"
srun "${SRUN_PARAMS[@]}" singularity exec --nv \
  --bind "${TOMOUNT}" \
  "${SINGULARITY_FILE}" \
  bash -c "export CUDA_VISIBLE_DEVICES=0,1,2,3; source ${VENV_NAME}/bin/activate; cd ${MADONNA}; CONFIG_NAME=${CONFIG_NAME} python -u ${TRAIN_SCRIPT}"
