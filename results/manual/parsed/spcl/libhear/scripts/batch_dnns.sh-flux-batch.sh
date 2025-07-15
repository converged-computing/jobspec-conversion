#!/bin/bash
#FLUX: --job-name="dlrm_resnet"
#FLUX: -N=16
#FLUX: -n=256
#FLUX: --exclusive
#FLUX: --queue=normal
#FLUX: -t=25200
#FLUX: --priority=16

BLOCK_SIZE=262144
BIN_DIR=$1
HEAR_LIB_DIR=$2
LOG_DIR=$3
LOG_PATH="${LOG_DIR}/logs_dnn/"
BINARY_PATH="${BIN_DIR}/"
HEAR_PATH="${HEAR_LIB_DIR}/libhear_release.so"
SRUN_CMD="mpirun -n 256 --hostfile=hostfile"
for app_name in {"cosmoflow","dlrm","resnet"}
do
    BASELINE_CMD="${SRUN_CMD} ${BINARY_PATH}/${app_name} &> ${LOG_PATH}/${app_name}.baseline.log"
    echo "$BASELINE_CMD"
    echo "$BASELINE_CMD" &> ${LOG_PATH}/${app_name}.baseline.cmd
    eval $BASELINE_CMD
    HEAR_CMD="HEAR_PIPELINING_BLOCK_SIZE=${BLOCK_SIZE} HEAR_MPOOL_SBUF_LEN=8388608 HEAR_ENABLE_AESNI=1 LD_PRELOAD=${HEAR_PATH} ${SRUN_CMD} ${BINARY_PATH}/${app_name} &> ${LOG_PATH}/${app_name}.hear.log"
    echo "$HEAR_CMD"
    echo "$HEAR_CMD" &> ${LOG_PATH}/${app_name}.hear.cmd
    eval $HEAR_CMD
done
