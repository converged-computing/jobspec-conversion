#!/bin/bash
#FLUX: --job-name=prompt_llama
#FLUX: -c=16
#FLUX: --queue=a40
#FLUX: --priority=16

export LOGLEVEL='INFO'
export NCCL_IB_DISABLE='1'
export NCCL_DEBUG='INFO'

echo "###############################"
echo "######## SBATCH SCRIPT ########"
echo "###############################"
TARGET_FOLDER=$1	# Path to LLaMA ckpt weights
ROOT_DIR=$(pwd)
LOG_DIR="${ROOT_DIR}/logs"
ENV_DIR="${ROOT_DIR}/llama_env"
NODES=( $( scontrol show hostnames ${SLURM_JOB_NODELIST} ) )
NODES_ARRAY=(${NODES})
HEAD_NODE=${NODES_ARRAY[0]}
HEAD_NODE_IP=$(srun --nodes=1 --ntasks=1 -w "${HEAD_NODE}" hostname --ip-address)
OUTFILE="${LOG_DIR}/output-%j-%t.out"
WORKER_SETUP_SCRIPT="${ROOT_DIR}/worker_script.sh"
PORT=42069
MODEL_SIZE="30B"
NNODES="${SLURM_JOB_NUM_NODES}"
WORKERS_PER_NODE="${SLURM_GPUS_ON_NODE}"
RDVZ_ID=6969
RDVZ_BACKEND="c10d"
RDVZ_ENDPOINT="${HEAD_NODE_IP}:${PORT}"
PYTHON_SCRIPT="${ROOT_DIR}/llama/example.py"
MAX_BATCH_SIZE=8
MAX_SEQ_LEN=256
CKPT_DIR="${TARGET_FOLDER}/${MODEL_SIZE}"
TOKENIZER_PATH="${TARGET_FOLDER}/tokenizer.model"
export LOGLEVEL=INFO
export NCCL_IB_DISABLE=1
export NCCL_DEBUG=INFO
echo "HEAD_NODE=${HEAD_NODE}"
echo "HEAD_NODE_IP=${HEAD_NODE_IP}"
echo "OUTFILE=${OUTFILE}"
echo "WORKER_SETUP_SCRIPT=${WORKER_SETUP_SCRIPT}"
echo "MODEL_SIZE=${MODEL_SIZE}"
echo "TARGET_FOLDER=${TARGET_FOLDER}"
echo "NNODES=${NNODES}"
echo "WORKERS_PER_NODE=${WORKERS_PER_NODE}"
echo "RDVZ_ID=${RDVZ_ID}"
echo "RDVZ_BACKEND=${RDVZ_BACKEND}"
echo "RDVZ_ENDPOINT=${RDVZ_ENDPOINT}"
echo "PYTHON_SCRIPT=${PYTHON_SCRIPT}"
echo "MAX_BATCH_SIZE=${MAX_BATCH_SIZE}"
echo "MAX_SEQ_LEN=${MAX_SEQ_LEN}"
echo "CKPT_DIR=${CKPT_DIR}"
echo "TOKENIZER_PATH=${TOKENIZER_PATH}"
read -r -d '' cmd << EOF
bash ${WORKER_SETUP_SCRIPT} \
${WORKERS_PER_NODE} \
${ENV_DIR} \
${NNODES} \
${MAX_BATCH_SIZE} \
${MAX_SEQ_LEN} \
${PYTHON_SCRIPT} \
${CKPT_DIR} \
${TOKENIZER_PATH} \
${RDVZ_ID} \
${RDVZ_BACKEND} \
${RDVZ_ENDPOINT}
EOF
echo "Running command:"
echo "${cmd}"
/opt/slurm/bin/srun -N "${SLURM_JOB_NUM_NODES}" -l -o "${OUTFILE}" -e "${OUTFILE}" bash -c "${cmd}"
