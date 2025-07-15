#!/bin/bash
#FLUX: --job-name=joyous-cupcake-5448
#FLUX: -c=8
#FLUX: --urgency=16

export NCCL_IB_DISABLE='1'

export NCCL_IB_DISABLE=1
if [[ "${SLURM_JOB_PARTITION}" == "t4v2" ]] || \
    [[ "${SLURM_JOB_PARTITION}" == "rtx6000" ]]; then
    echo export NCCL_SOCKET_IFNAME=bond0 on "${SLURM_JOB_PARTITION}"
    export NCCL_SOCKET_IFNAME=bond0
fi
SERVER_PORT=$1
CONFIG_PATH=$2
LOG_DIR=$3
VENV_PATH=$4
N_CLIENTS=$5
echo "Node Name: ${SLURMD_NODENAME}"
echo "Server Port number: ${SERVER_PORT}"
echo "Config Path: ${CONFIG_PATH}"
echo "Python Venv Path: ${VENV_PATH}"
SERVER_ADDRESS="${SLURMD_NODENAME}:${SERVER_PORT}"
echo "Server Address: ${SERVER_ADDRESS}"
LOG_PATH="${LOG_DIR}server.log"
echo "Placing logs in: ${LOG_DIR}"
echo "World size: ${SLURM_NTASKS}"
echo "Number of nodes: ${SLURM_NNODES}"
NUM_GPUs=$(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l)
echo "GPUs per node: ${NUM_GPUs}"
source ${VENV_PATH}bin/activate
echo "Active Environment"
which python
python -m research.picai.fedavg.server --config_path ${CONFIG_PATH} --server_address ${SERVER_ADDRESS} --artifact_dir ${LOG_DIR} --n_clients ${N_CLIENTS} > ${LOG_PATH} 2>&1
echo ${SERVER_ADDRESS}
