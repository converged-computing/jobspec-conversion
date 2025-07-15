#!/bin/bash
#FLUX: --job-name=central_picai
#FLUX: -c=8
#FLUX: --urgency=16

LOG_DIR=$1
VENV_PATH=$2
FOLD_ID=$3
RUN_NAME=$4
echo "Config Path: ${CONFIG_PATH}"
echo "Python Venv Path: ${VENV_PATH}"
echo "Fold ID: ${FOLD_ID}"
LOG_PATH="${LOG_DIR}client_${JOB_HASH}.log"
echo "Placing logs in: ${LOG_DIR}"
echo "World size: ${SLURM_NTASKS}"
echo "Number of nodes: ${SLURM_NNODES}"
NUM_GPUs=$(nvidia-smi --query-gpu=name --format=csv,noheader | wc -l)
echo "GPUs per node: ${NUM_GPUs}"
source ${VENV_PATH}bin/activate
echo "Active Environment:"
which python
python ~/FL4Health/research/picai/central/train.py --checkpoint_dir ${LOG_DIR} --fold ${FOLD_ID} --run_name ${RUN_NAME} > ${LOG_PATH} 2>&1
