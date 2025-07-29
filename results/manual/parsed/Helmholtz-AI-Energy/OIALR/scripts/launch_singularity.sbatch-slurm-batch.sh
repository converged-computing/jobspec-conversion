#!/bin/bash
#FLUX: --job-name=madonna-test
#FLUX: --queue=sdil
#FLUX: -t=14400
#FLUX: --urgency=16

export TOMOUNT='${TOMOUNT}'
export UCX_MEMTYPE_CACHE='0'
export NCCL_IB_TIMEOUT='100'
export SHARP_COLL_LOG_LEVEL='3'
export OMPI_MCA_coll_hcoll_enable='0'
export NCCL_SOCKET_IFNAME='ib0'
export NCCL_COLLNET_ENABLE='0'
export CUDA_VISIBLE_DEVICES='0,1,2,3'
export CONFIG_NAME='ortho_train.yaml'

ml purge
BASE_DIR="/hkfs/work/workspace/scratch/CHANGE/ME-madonna/"
TOMOUNT='/etc/slurm/task_prolog.hk:/etc/slurm/task_prolog.hk,'
TOMOUNT+="${BASE_DIR},"
TOMOUNT+="/scratch,/tmp,"
TOMOUNT+="/hkfs/work/workspace/scratch/CHANGE/ME-dlrt2/datasets"
export TOMOUNT="${TOMOUNT}"
SRUN_PARAMS=(
  --mpi="pmi2"
  --gpus-per-task=1
  # --cpus-per-task=8
  #--cpu-bind="ldoms"
  # --gpu-bind="closest"
  --label
  --pty
)
SCRIPT_DIR="/pfs/work7/workspace/scratch/CHANGE/ME-madonna/CHANGE/ME-madonna/madonna"
export UCX_MEMTYPE_CACHE=0
export NCCL_IB_TIMEOUT=100
export SHARP_COLL_LOG_LEVEL=3
export OMPI_MCA_coll_hcoll_enable=0
export NCCL_SOCKET_IFNAME="ib0"
export NCCL_COLLNET_ENABLE=0
BASE_DIR="/pfs/work7/workspace/scratch/CHANGE/ME-madonna/CHANGE/ME-madonna/madonna"
TOMOUNT="/pfs/work7/workspace/scratch/CHANGE/ME-madonna/CHANGE/ME-madonna/,/scratch,"
TOMOUNT+="/sys,/tmp,"
TOMOUNT+="/home/kit/scc/CHANGE/ME/"
export CUDA_VISIBLE_DEVICES="0,1,2,3"
export CONFIG_NAME="ortho_train.yaml"
PATH=$PATH:/home/kit/scc/CHANGE/ME/.local/bin srun "${SRUN_PARAMS[@]}" singularity exec --nv \
  --bind "${TOMOUNT}" \
  "${SINGULARITY_FILE}" \
  echo $PATH
  # /bin/sh -c "export PATH=$PATH:/home/kit/scc/CHANGE/ME/.local/bin; CONFIG_NAME=${CONFIG_NAME} python -u ${SCRIPT_DIR}madonna/scripts/train.py"
