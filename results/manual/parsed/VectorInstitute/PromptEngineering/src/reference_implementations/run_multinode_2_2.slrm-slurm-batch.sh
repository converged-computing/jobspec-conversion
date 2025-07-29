#!/bin/bash
#SBATCH --job-name=prompt-multinode-experiments
#SBATCH --output=job_%x_%j.out
#SBATCH --error=job_%x_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:2
#SBATCH --mem=64G
#SBATCH --qos=high
#SBATCH --constraint=ntasks-per-node=2

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
MODEL_DIR=$3
DATA_DIR=$4
echo "Placing logs in: ${LOG_DIR}"
echo "World size: ${SLURM_NTASKS}"
echo "Number of nodes: ${SLURM_NNODES}"
nvidia-smi
NUM_GPUs=$(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l)
echo "GPUs per node: ${NUM_GPUs}"
mkdir -p "${LOG_DIR}"
/opt/slurm/bin/srun -N "${SLURM_NNODES}" -l \
    bash -c "bash ${SCRIPT} DATA_DIR=${DATA_DIR} MODEL_DIR=${MODEL_DIR} >> ${LOG_PATH} 2>&1"
