#!/bin/bash
#FLUX: --job-name=hackasaurous
#FLUX: --exclusive
#FLUX: --queue=accelerated
#FLUX: -t=14400
#FLUX: --urgency=16

export TOMOUNT='${TOMOUNT}'
export CUDA_VISIBLE_DEVICES='0,1,2,3'
export UCX_MEMTYPE_CACHE='0'
export NCCL_IB_TIMEOUT='100'
export SHARP_COLL_LOG_LEVEL='3'
export OMPI_MCA_coll_hcoll_enable='0'
export NCCL_SOCKET_IFNAME='ib0'
export NCCL_COLLNET_ENABLE='0'

ml purge
BASE_DIR="/hkfs/work/workspace_haic/scratch/bk6983-ai_hero_hackathon_shared"
DATA_DIR="/hkfs/work/workspace/scratch/ih5525-energy-train-data"
TOMOUNT=${TOMOUNT:-""}
TOMOUNT+="${BASE_DIR},${DATA_DIR},"
TOMOUNT+="/scratch,/tmp,"
TOMOUNT+='/etc/slurm/task_prolog.hk'
TOMOUNT+=",/hkfs/work/workspace/scratch/qv2382-hackathon/"
TOMOUNT+=",/hkfs/work/workspace/scratch/ih5525-E2/"
export TOMOUNT="${TOMOUNT}"
SRUN_PARAMS=(
  --mpi="pmix"  # TODO: unknown if pmix is there or not!!
  --cpus-per-task=16  # TODO: num
  #--cpu-bind="ldoms"
  # --gpu-bind="closest"
  --label
  --container-name=torch
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
COMMAND=${COMMAND:-"python -u /hkfs/work/workspace/scratch/qv2382-hackathon/Hackasaurus-Rex/scripts/train.py -c /hkfs/work/workspace/scratch/qv2382-hackathon/Hackasaurus-Rex/configs/detr_prot.yml"}
srun "${SRUN_PARAMS[@]}" bash -c "${COMMAND}"
