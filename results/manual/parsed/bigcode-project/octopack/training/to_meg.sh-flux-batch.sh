#!/bin/bash
#FLUX: --job-name=xp3mixedjsonl
#FLUX: -c=40
#FLUX: --queue=cpu_p1
#FLUX: -t=72000
#FLUX: --urgency=16

export HF_DATASETS_OFFLINE='1'
export TRANSFORMERS_OFFLINE='1'

set -x -e
source $six_ALL_CCFRWORK/start-tr13f-6B3-ml-t0
export HF_DATASETS_OFFLINE=1
export TRANSFORMERS_OFFLINE=1
MEGATRON_DEEPSPEED_REPO=$six_ALL_CCFRWORK/code/tr13f-6B3-ml-t0/Megatron-DeepSpeed
TOKENIZER_PATH="bigscience/tokenizer"
mkdir -p $OUTPUT
LANGS=(
code
)
DATA_PATH=/gpfswork/rech/six/commun/bigscience-training/jsonls/xp3cappedmixednewcode
OUTPUT=/gpfswork/rech/six/commun/bigscience-training/xp3cappedmixednewcodelong
mkdir -p $OUTPUT
for val in {0..1}; do
    LANG=${LANGS[$val]}
    cd $DATA_PATH/$LANG
    # Merge
    cat *.jsonl > merged_dups_$LANG.jsonl
    # Drop duplicates (~1G / 37G for en) + Shuffle
    sort -u merged_dups_$LANG.jsonl | shuf > merged_$LANG.jsonl
    cd $MEGATRON_DEEPSPEED_REPO
    python tools/preprocess_data.py \
        --input $DATA_PATH/$LANG/merged_$LANG.jsonl \
        --output-prefix $OUTPUT/xp3_$LANG \
        --dataset-impl mmap \
        --json-key inputs \
        --tokenizer-type PretrainedFromHF \
        --tokenizer-name-or-path $TOKENIZER_PATH \
        --workers 35
    python tools/preprocess_data.py \
        --input $DATA_PATH/$LANG/merged_$LANG.jsonl \
        --output-prefix $OUTPUT/xp3_$LANG \
        --dataset-impl mmap \
        --json-key targets \
        --tokenizer-type PretrainedFromHF \
        --tokenizer-name-or-path $TOKENIZER_PATH \
        --append-eod \
        --workers 35
done
