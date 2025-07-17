#!/bin/bash
#FLUX: --job-name=quirky-hippo-4326
#FLUX: -c=8
#FLUX: --urgency=16

export NCCL_IB_DISABLE='1'
export CUDA_LAUNCH_BLOCKING='1'

export NCCL_IB_DISABLE=1
export CUDA_LAUNCH_BLOCKING=1
if [[ "${SLURM_JOB_PARTITION}" == "t4v2" ]] || \
    [[ "${SLURM_JOB_PARTITION}" == "rtx6000" ]]
    [[ "${SLURM_JOB_PARTITION}" == "a40" ]]; then
    echo export NCCL_SOCKET_IFNAME=bond0 on "${SLURM_JOB_PARTITION}"
    export NCCL_SOCKET_IFNAME=bond0
fi
SERVER_ADDRESS=$1
LOG_DIR=$2
VENV_PATH=$3
JOB_HASH=$4
DATA_PARTITION=$5
echo "Server Address: ${SERVER_ADDRESS}"
echo "Python Venv Path: ${VENV_PATH}"
echo "Job Hash: ${JOB_HASH}"
LOG_PATH="${LOG_DIR}client_${JOB_HASH}.log"
echo "Placing logs in: ${LOG_DIR}"
echo "World size: ${SLURM_NTASKS}"
echo "Number of nodes: ${SLURM_NNODES}"
NUM_GPUs=$(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l)
echo "GPUs per node: ${NUM_GPUs}"
source ${VENV_PATH}bin/activate
echo "Active Environment:"
which python
echo "Server Address used by Client: ${SERVER_ADDRESS}"
python -m research.picai.fedavg.client --server_address ${SERVER_ADDRESS} --artifact_dir ${LOG_DIR} --data_partition ${DATA_PARTITION} > ${LOG_PATH} 2>&1
