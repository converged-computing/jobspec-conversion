#!/bin/bash
#FLUX: --job-name=megatron_preprocess
#FLUX: -c=4
#FLUX: --gpus-per-task=1
#FLUX: --queue=hpg-ai
#FLUX: -t=43200
#FLUX: --urgency=16

pwd; hostname; date
CONTAINER=./containers/pytorch.sif # a container has no megatron and nemo installed
singularity exec $CONTAINER python merge_megatron_preprocessing_bin_files.py \
    --input ./to_merge \
    --output ./uf_full_uf30kcased \
    --output_prefix uf_full_uf30kcased_TEXT \
    --vocab_file ./vocab.txt \
    --tokenizer_type BertWordPieceCase
date
