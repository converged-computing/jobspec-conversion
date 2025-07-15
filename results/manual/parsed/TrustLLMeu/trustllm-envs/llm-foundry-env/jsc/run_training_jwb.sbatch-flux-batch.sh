#!/bin/bash
#FLUX: --job-name=buttery-cat-7339
#FLUX: -c=48
#FLUX: --queue=develbooster
#FLUX: -t=1200
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='$SLURM_CPUS_PER_TASK'
export MASTER_ADDR='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)'
export MASTER_PORT='54123'
export DEVICES_PER_NODE='4'
export TRAIN_NUM_WORKERS='8'
export EVAL_NUM_WORKERS='3'
export TRAIN_CONFIG_YAML_FILE='train/yamls/pretrain/mpt-125m.yaml'
export INPUT_DATA_ROOT_DIR='$data_dir"/my-tiny-c4-gpt2-tok'
export TOKENIZER_DIR='/p/scratch/trustllm-eu/example-data/gpt2-tokenizer'
export MODEL_CHECKPOINT_DIR='$checkpoint_dir"/mpt-125m'

set -euo pipefail
_curr_file="$(scontrol show job "$SLURM_JOB_ID" | grep '^[[:space:]]*Command=' | head -n 1 | cut -d '=' -f 2-)"
_curr_dir="$(dirname "$_curr_file")"
source "$_curr_dir"/../../global-scripts/get_curr_file.sh "$_curr_file"
source "$(get_curr_dir)"/../configuration.sh
export SRUN_CPUS_PER_TASK="$SLURM_CPUS_PER_TASK"
export MASTER_ADDR="$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)"
if [ "$SYSTEMNAME" = juwelsbooster ] \
       || [ "$SYSTEMNAME" = juwels ] \
       || [ "$SYSTEMNAME" = jurecadc ]; then
    # Allow communication over InfiniBand cells on JSC machines.
    MASTER_ADDR="$MASTER_ADDR"i
fi
export MASTER_PORT=54123
export DEVICES_PER_NODE=4
export TRAIN_NUM_WORKERS=8
export EVAL_NUM_WORKERS=3
export TRAIN_CONFIG_YAML_FILE=train/yamls/pretrain/mpt-125m.yaml
export INPUT_DATA_ROOT_DIR="$data_dir"/my-tiny-c4-gpt2-tok
export TOKENIZER_DIR=/p/scratch/trustllm-eu/example-data/gpt2-tokenizer
export MODEL_CHECKPOINT_DIR="$checkpoint_dir"/mpt-125m
_curr_dir="$(get_curr_dir)"
srun bash -c "
    export WORLD_SIZE=\"\$((SLURM_JOB_NUM_NODES * DEVICES_PER_NODE))\"; \\
    export NODE_RANK=\"\$SLURM_NODEID\"; \\
    bash ${_curr_dir@Q}/../container_run.sh \\
        bash ${training_script@Q}
"
pop_curr_file
