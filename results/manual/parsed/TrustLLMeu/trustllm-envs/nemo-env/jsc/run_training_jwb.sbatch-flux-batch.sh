#!/bin/bash
#FLUX: --job-name=quirky-chip-6027
#FLUX: -N=2
#FLUX: -c=12
#FLUX: --queue=develbooster
#FLUX: -t=1200
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='$SLURM_CPUS_PER_TASK'
export MASTER_ADDR='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)'
export MASTER_PORT='54123'
export GLOO_SOCKET_IFNAME='ib0'
export NCCL_IB_TIMEOUT='20'
export DEVICES_PER_NODE='4'
export NUM_NODES='$SLURM_JOB_NUM_NODES'
export PER_SPLIT_NUM_WORKERS='5'
export TRAIN_CONFIG_YAML_DIR='$ext_repo_dir"/NeMo/examples/nlp/language_modeling/conf'
export TRAIN_CONFIG_YAML_NAME='megatron_llama_config'
export TRAIN_DATA_PREFIX='$data_dir"/my-tiny-c4-gpt2-tok/train_text_document'
export EVAL_DATA_PREFIX='$data_dir"/my-tiny-c4-gpt2-tok/val_text_document'
export TEST_DATA_PREFIX='$EVAL_DATA_PREFIX'
export TOKENIZER_VOCAB_FILE='/p/scratch/trustllm-eu/example-data/gpt2-tokenizer/vocab.json'
export TOKENIZER_MERGE_FILE='/p/scratch/trustllm-eu/example-data/gpt2-tokenizer/merges.txt'
export TOKENIZER_MODEL_FILE='/p/scratch/trustllm-eu/example-data/t5-small-tokenizer/spiece.model'
export MODEL_CHECKPOINT_DIR='$checkpoint_dir'

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
export GLOO_SOCKET_IFNAME=ib0
export NCCL_IB_TIMEOUT=20
export DEVICES_PER_NODE=4
export NUM_NODES="$SLURM_JOB_NUM_NODES"
export PER_SPLIT_NUM_WORKERS=5
export TRAIN_CONFIG_YAML_DIR="$ext_repo_dir"/NeMo/examples/nlp/language_modeling/conf
export TRAIN_CONFIG_YAML_NAME=megatron_llama_config
export TRAIN_DATA_PREFIX="$data_dir"/my-tiny-c4-gpt2-tok/train_text_document
export EVAL_DATA_PREFIX="$data_dir"/my-tiny-c4-gpt2-tok/val_text_document
export TEST_DATA_PREFIX="$EVAL_DATA_PREFIX"
export TOKENIZER_VOCAB_FILE=/p/scratch/trustllm-eu/example-data/gpt2-tokenizer/vocab.json
export TOKENIZER_MERGE_FILE=/p/scratch/trustllm-eu/example-data/gpt2-tokenizer/merges.txt
export TOKENIZER_MODEL_FILE=/p/scratch/trustllm-eu/example-data/t5-small-tokenizer/spiece.model
export MODEL_CHECKPOINT_DIR="$checkpoint_dir"
srun env -u CUDA_VISIBLE_DEVICES bash "$(get_curr_dir)"/../container_run.sh \
     bash "$training_script"
pop_curr_file
