#!/bin/bash
#FLUX: --job-name=propulate-optuna-sphere
#FLUX: --queue=accelerated
#FLUX: -t=7200
#FLUX: --urgency=16

export DATA_DIR='/hkfs/work/workspace/scratch/qv2382-bigearthnet/'
export BASE_DIR='/hkfs/work/workspace/scratch/qv2382-propulate/'
export SQL_DATA_DIR='${BASE_DIR}sqldata/optuna'
export SQL_CONFIG='${BASE_DIR}bigearthnet_kit/my.cnf'
export SQL_SOCKET='${BASE_DIR}mysqld.sock'
export SQL_SOCKET_DIR='${BASE_DIR}bigearthnet_kit/mysql/'
export SEED='${RANDOM}'
export UCX_MEMTYPE_CACHE='0'
export NCCL_IB_TIMEOUT='100'
export SHARP_COLL_LOG_LEVEL='3'
export OMPI_MCA_coll_hcoll_enable='0'
export NCCL_SOCKET_IFNAME='ib0'
export NCCL_COLLNET_ENABLE='0'

ml purge
SRUN_PARAMS=(
  --mpi="pmi2"
  --label
)
export DATA_DIR="/hkfs/work/workspace/scratch/qv2382-bigearthnet/"
export BASE_DIR="/hkfs/work/workspace/scratch/qv2382-propulate/"
export SQL_DATA_DIR="${BASE_DIR}sqldata/optuna"
export SQL_CONFIG="${BASE_DIR}bigearthnet_kit/my.cnf"
export SQL_SOCKET="${BASE_DIR}mysqld.sock"
touch "$SQL_SOCKET"
export SQL_SOCKET_DIR="${BASE_DIR}bigearthnet_kit/mysql/"
export SEED="${RANDOM}"
CONTAINER_DIR="${BASE_DIR}containers/"
SINGULARITY_FILE="${CONTAINER_DIR}scratch-tf-sql.sif"
echo "${SINGULARITY_FILE}"
export UCX_MEMTYPE_CACHE=0
export NCCL_IB_TIMEOUT=100
export SHARP_COLL_LOG_LEVEL=3
export OMPI_MCA_coll_hcoll_enable=0
export NCCL_SOCKET_IFNAME="ib0"
export NCCL_COLLNET_ENABLE=0
srun "${SRUN_PARAMS[@]}" singularity exec --nv \
  --bind "${BASE_DIR}","${DATA_DIR}","/scratch","$TMP",${SQL_DATA_DIR}:/var/lib/mysql,${SQL_SOCKET_DIR}:/run/mysqld \
  --bind "${SQL_SOCKET_DIR}/var/log/mysql/":/var/log/mysql \
  ${SINGULARITY_FILE} \
  bash optuna_sphere.sh
