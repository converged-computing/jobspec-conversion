#!/bin/bash
#FLUX: --job-name=optuna-bisphere
#FLUX: -N=2
#FLUX: --queue=cpuonly
#FLUX: -t=43200
#FLUX: --urgency=16

export FNAME='bisphere'
export FRAMEWORK='optuna'
export EVALS_PER_WORKER='256'
export DATA_DIR='/hkfs/work/workspace/scratch/qv2382-bigearthnet/'
export BASE_DIR='/hkfs/work/workspace/scratch/qv2382-propulate/'
export SQL_DATA_DIR='${BASE_DIR}sqldata/${FNAME}'
export SQL_CONFIG='${BASE_DIR}exps/function_benchmark/mysqlconfs/${FNAME}.cnf'
export SQL_SOCKET='${BASE_DIR}bigearthnet_kit/mysql/${FNAME}/var/run/mysqld/mysqld.sock'
export SQL_DIR='${BASE_DIR}bigearthnet_kit/mysql/${FNAME}/'
export UCX_MEMTYPE_CACHE='0'
export NCCL_IB_TIMEOUT='100'
export SHARP_COLL_LOG_LEVEL='3'
export OMPI_MCA_coll_hcoll_enable='0'
export NCCL_SOCKET_IFNAME='ib0'
export NCCL_COLLNET_ENABLE='0'

ml purge
export FNAME="bisphere"
SRUN_PARAMS=(
  --mpi="pmi2"
  --label
)
export FRAMEWORK="optuna"
export EVALS_PER_WORKER=256
export DATA_DIR="/hkfs/work/workspace/scratch/qv2382-bigearthnet/"
export BASE_DIR="/hkfs/work/workspace/scratch/qv2382-propulate/"
export SQL_DATA_DIR="${BASE_DIR}sqldata/${FNAME}"
export SQL_CONFIG="${BASE_DIR}exps/function_benchmark/mysqlconfs/${FNAME}.cnf"
export SQL_SOCKET="${BASE_DIR}bigearthnet_kit/mysql/${FNAME}/var/run/mysqld/mysqld.sock"
mkdir "${BASE_DIR}bigearthnet_kit/mysql/${FNAME}/var/run/mysqld/"
rm "${BASE_DIR}bigearthnet_kit/mysql/${FNAME}/var/run/mysqld/*"
chmod 777 "${BASE_DIR}bigearthnet_kit/mysql/${FNAME}"
export SQL_DIR="${BASE_DIR}bigearthnet_kit/mysql/${FNAME}/"
CONTAINER_DIR="${BASE_DIR}containers/"
SINGULARITY_FILE="${CONTAINER_DIR}scratch-tf-sql.sif"
echo "${SINGULARITY_FILE}"
export UCX_MEMTYPE_CACHE=0
export NCCL_IB_TIMEOUT=100
export SHARP_COLL_LOG_LEVEL=3
export OMPI_MCA_coll_hcoll_enable=0
export NCCL_SOCKET_IFNAME="ib0"
export NCCL_COLLNET_ENABLE=0
srun "${SRUN_PARAMS[@]}" singularity exec \
  --bind /hkfs/work/workspace/scratch/qv2382-propulate/ \
  --bind /hkfs/work/workspace/scratch/qv2382-propulate/bigearthnet_kit/mysql/bisphere/var/lib/mysql/:/var/lib/mysql \
  --bind /hkfs/work/workspace/scratch/qv2382-propulate/bigearthnet_kit/mysql/bisphere/run/mysqld:/run/mysqld \
  --bind /hkfs/work/workspace/scratch/qv2382-propulate/bigearthnet_kit/mysql/bisphere/var/log/mysql/:/var/log/mysql \
  --bind "${DATA_DIR}","/scratch","$TMP" \
  --bind "/hkfs/work/workspace/scratch/qv2382-propulate/propulate/propulate/wrapper.py":"/usr/local/lib/python3.8/dist-packages/propulate/wrapper.py" \
  --bind "/hkfs/work/workspace/scratch/qv2382-propulate/propulate/propulate/propulator.py":"/usr/local/lib/python3.8/dist-packages/propulate/propulator.py" \
  ${SINGULARITY_FILE} \
  bash optuna.sh
