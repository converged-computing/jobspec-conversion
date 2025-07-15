#!/bin/bash
#FLUX: --job-name=baseline
#FLUX: -t=3600
#FLUX: --urgency=16

module purge  # suggested in alliancecan docs: https://docs.alliancecan.ca/wiki/Running_jobs
module load python/3.10 StdEnv/2020 gcc/9.3.0 arrow/7.0.0
PROJECT_NAME="mediqa"
ACCOUNT_NAME="def-wanglab-ab"
source "$HOME/$PROJECT_NAME/bin/activate"
cd "$HOME/projects/$ACCOUNT_NAME/$USER/$PROJECT_NAME-chat-tasks-acl-2023" || exit
CONFIG_FILEPATH="$1"  # The path on disk to the JSON config file
OUTPUT_DIR="$2"       # The path on disk to save the output to
WANDB_MODE=offline \
TRANSFORMERS_OFFLINE=1 \
HF_DATASETS_OFFLINE=1 \
HF_EVALUATE_OFFLINE=1 \
python ./scripts/run_summarization.py "./conf/base.yml" "$CONFIG_FILEPATH" output_dir="$OUTPUT_DIR" \
    cache_dir="$SCRATCH/.cache/huggingface" overwrite_output_dir=true bleurt_checkpoint=null \
exit
