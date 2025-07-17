#!/bin/bash
#FLUX: --job-name=catalogue-jsonl-to-meg-ds
#FLUX: -c=40
#FLUX: --queue=cpu_p1
#FLUX: -t=72000
#FLUX: --urgency=16

export HF_DATASETS_OFFLINE='1'
export TRANSFORMERS_OFFLINE='1'

set -x -e
source $six_ALL_CCFRWORK/start-prod
conda activate thomas_data_tooling
DATASET_PATHS=($(ls -d $six_ALL_CCFRWORK/bigscience-training/jsonls/**/**/*.jsonl))
DATASET_PATH=${DATASET_PATHS[$SLURM_ARRAY_TASK_ID]}
TOKENIZER_NAME_OR_PATH=bigscience-catalogue-data-dev/byte-level-bpe-tokenizer-no-norm-250k-whitespace-and-eos-regex-alpha-v3-dedup-lines-articles
DATASET_NAME_WITH_JSONL=$(basename $DATASET_PATH)
DATASET_NAME=${DATASET_NAME_WITH_JSONL:0:-6}
LANG=$(basename $(dirname $DATASET_PATH))
SAVE_MEG_DS_DATASET=$six_ALL_CCFRSCRATCH/bigscience-datasets/re-tokenizations/$LANG/"$DATASET_NAME"/meg_ds_"${TOKENIZER_NAME_OR_PATH//\//_}"
mkdir -p $(dirname $SAVE_MEG_DS_DATASET)
if [[ -f "$SAVE_MEG_DS_DATASET"_text_document.bin ]];
then
    echo "$SAVE_MEG_DS_DATASET exists."
    exit 0
fi
export HF_DATASETS_OFFLINE=1
export TRANSFORMERS_OFFLINE=1
cd $six_ALL_CCFRWORK/code/Megatron-DeepSpeed
/usr/bin/time -v python tools/preprocess_data_many_cores.py \
       --input $DATASET_PATH \
       --output-prefix $SAVE_MEG_DS_DATASET \
       --dataset-impl mmap \
       --tokenizer-type PretrainedFromHF \
       --tokenizer-name-or-path $TOKENIZER_NAME_OR_PATH \
       --append-eod \
       --workers 40
