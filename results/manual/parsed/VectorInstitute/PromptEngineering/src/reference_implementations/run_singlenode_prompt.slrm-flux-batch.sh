#!/bin/bash
#FLUX: --job-name=prompt-singlenode-experiments
#FLUX: -c=4
#FLUX: --queue=a40
#FLUX: --urgency=16

export MASTER_ADDR='$MAIN_HOST'
export MASTER_PORT='52069'
export NCCL_IB_DISABLE='1'

MAIN_HOST=$(hostname -s)
export MASTER_ADDR=$MAIN_HOST
export MASTER_PORT=52069
export NCCL_IB_DISABLE=1
if [[ "${SLURM_JOB_PARTITION}" == "t4v2" ]] || \
    [[ "${SLURM_JOB_PARTITION}" == "rtx6000" ]]; then
    echo export NCCL_SOCKET_IFNAME=bond0 on "${SLURM_JOB_PARTITION}"
    export NCCL_SOCKET_IFNAME=bond0
fi
SCRIPT=$1
LOG_DIR=$2
LOG_PATH="${LOG_DIR}/log_${SLURM_JOB_ID}_rank_\${SLURM_PROCID}.log"
EXP_TYPE=$3
TASK=$4
MODEL_PATH=$5
LR=$6
LEN=$7
echo "Placing logs in: ${LOG_DIR}"
echo "World size: ${SLURM_NTASKS}"
echo "Number of nodes: ${SLURM_NNODES}"
NUM_GPUs=$(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l)
echo "GPUs per node: ${NUM_GPUs}"
mkdir -p "${LOG_DIR}"
/opt/slurm/bin/srun -N"${SLURM_NNODES}" -l \
    bash -c "bash ${SCRIPT} MODEL_PATH=${MODEL_PATH} \
             LEN=${LEN} EXP_TYPE=${EXP_TYPE} LR=${LR} \
             TASK=${TASK} >> ${LOG_PATH} 2>&1"
