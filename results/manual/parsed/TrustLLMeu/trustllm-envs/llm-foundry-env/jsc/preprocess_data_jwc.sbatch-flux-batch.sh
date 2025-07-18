#!/bin/bash
#FLUX: --job-name=loopy-citrus-9932
#FLUX: -c=48
#FLUX: --queue=devel
#FLUX: -t=1200
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='$SLURM_CPUS_PER_TASK'
export INPUT_DATA_FILE='/p/scratch/trustllm-eu/example-data/tiny-c4-10k.jsonl'
export TOKENIZER_DIR='/p/scratch/trustllm-eu/example-data/gpt2-tokenizer'
export OUTPUT_DATA_DIR='$data_dir"/my-tiny-c4-gpt2-tok/val'

set -euo pipefail
_curr_file="$(scontrol show job "$SLURM_JOB_ID" | grep '^[[:space:]]*Command=' | head -n 1 | cut -d '=' -f 2-)"
_curr_dir="$(dirname "$_curr_file")"
source "$_curr_dir"/../../global-scripts/get_curr_file.sh "$_curr_file"
source "$(get_curr_dir)"/../configuration.sh
export SRUN_CPUS_PER_TASK="$SLURM_CPUS_PER_TASK"
export INPUT_DATA_FILE=/p/scratch/trustllm-eu/example-data/tiny-c4-10k.jsonl
export TOKENIZER_DIR=/p/scratch/trustllm-eu/example-data/gpt2-tokenizer
export OUTPUT_DATA_DIR="$data_dir"/my-tiny-c4-gpt2-tok/val
srun bash "$(get_curr_dir)"/../container_run.sh \
     bash "$preprocessing_script"
pop_curr_file
