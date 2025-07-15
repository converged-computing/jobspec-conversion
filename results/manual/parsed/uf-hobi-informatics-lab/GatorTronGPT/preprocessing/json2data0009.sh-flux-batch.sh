#!/bin/bash
#FLUX: --job-name=json2data
#FLUX: -c=128
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpu
#FLUX: -t=518400
#FLUX: --urgency=16

root=/red/gatortron-phi/gpt
data_root=/red/gatortron-phi/gpt/data/ThePile_raw_json/the-eye.eu/public/AI/pile/train
vocab=${root}/vocab/gpt2-vocab.json
merge_file=${root}/vocab/gpt2-merges.txt
CONTAINER=${root}/containers/py2103.sif
i=$SLURM_ARRAY_TASK_ID
DATA=${data_root}/0${i}.jsonl
PREFIX=${root}/data/new_preprocessed_thepile/thepile_0${i}_bin
singularity exec --nv $CONTAINER python ${root}/Megatron-LM-2022/tools/preprocess_data.py \
        --input $DATA \
        --json-keys text \
        --tokenizer-type GPT2BPETokenizer \
        --vocab-file $vocab \
        --merge-file $merge_file \
        --output-prefix $PREFIX \
        --dataset-impl mmap \
        --workers 120 \
        --append-eod \
        --log-interval 10000
