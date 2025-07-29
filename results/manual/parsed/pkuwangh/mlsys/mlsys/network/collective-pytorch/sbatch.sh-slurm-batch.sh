#!/bin/bash
#SBATCH --job-name=collective
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --constraint=ntasks-per-node=1

export MLSYS_ROOT='${CURR_DIR}/../../..'
export MADDR='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)'

CURR_DIR=`pwd`
export MLSYS_ROOT="${CURR_DIR}/../../.."
TARGET_BIN="${MLSYS_ROOT}/mlsys/network/collective-pytorch/srun.sh"
export MADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
srun -u -l \
    --container-image=nvcr.io/nvidia/pytorch:23.12-py3 \
    --container-mounts "${MLSYS_ROOT}:${MLSYS_ROOT}" \
    "${TARGET_BIN}"
