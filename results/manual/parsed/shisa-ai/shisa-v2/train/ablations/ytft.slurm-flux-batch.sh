#!/bin/bash
#FLUX: --job-name=llm-cpt
#FLUX: -N=10
#FLUX: --exclusive
#FLUX: --queue=defq
#FLUX: --priority=16

export HF_HUB_ENABLE_HF_TRANSFER='1 '
export ACCELERATE_LOG_LEVEL='info '
export TRANSFORMERS_VERBOSITY='info'
export NCCL_ASYNC_ERROR_HANDLING='1'
export NCCL_TIMEOUT='7200000'
export WANDB_PROJECT='LLM-CPT'
export PROGRAM='\'
export CMD='$LAUNCHER $PROGRAM'

echo "START TIME: $(date)"
declare -a ARGS=(
	--container-image /mnt/home/f08944064/axolotl/axolotl_latest.sqsh
	--container-mounts /mnt/home/f08944064//axolotl:/workspace/axolotl,/mnt/home/f08944064/.cache/huggingface:/root/.cache/huggingface,/mnt/:/mnt/,/tmp/:/tmp/
	--container-writable
)
set -eo pipefail
set -x
LOG_PATH="main_log.txt"
ACCELERATE_CONFIG_FILE=config.yaml
export HF_HUB_ENABLE_HF_TRANSFER=1 
export ACCELERATE_LOG_LEVEL=info 
export TRANSFORMERS_VERBOSITY=info
export NCCL_ASYNC_ERROR_HANDLING=1
export NCCL_TIMEOUT=7200000
export WANDB_PROJECT="LLM-CPT"
GPUS_PER_NODE=8
NNODES=$SLURM_NNODES
NUM_PROCESSES=$(expr $NNODES \* $GPUS_PER_NODE)
MASTER_ADDR=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
MASTER_PORT=6000
LAUNCHER="/root/miniconda3/envs/py3.10/bin/python -u -m accelerate.commands.launch \
    --rdzv_conf "rdzv_backend=c10d,rdzv_endpoint=$MASTER_ADDR:$MASTER_PORT" \
    --config_file $ACCELERATE_CONFIG_FILE \
    --main_process_ip $MASTER_ADDR \
    --main_process_port $MASTER_PORT \
    --machine_rank \$SLURM_PROCID \
    --num_machines $NNODES \
    --num_processes $NUM_PROCESSES \
    --role \$(hostname -s|tr -dc '0-9'): --tee 3 \
    "
export PROGRAM="\
    ${2:-"-m axolotl.cli.train"} \
    $1 \
"
export CMD="$LAUNCHER $PROGRAM"
echo $CMD
SRUN_ARGS=" \
    -l "${ARGS[@]}" \
    --wait=60 \
    --kill-on-bad-exit=1 \
    --jobid $SLURM_JOB_ID \
"
srun \
    $SRUN_ARGS \
    bash -c \
    "$CMD" 2>&1 | tee -a $LOG_PATH
echo "END TIME: $(date)"
