#!/bin/bash
#FLUX: --job-name=expensive-parrot-0189
#FLUX: -c=128
#FLUX: --exclusive
#FLUX: --urgency=16

: "${APPS_PATH:=/fsx}"
: "${MODEL_PATH:=/fsx}"
: "${DATA_PATH:=/fsx/data/books}"
source ${APPS_PATH}/aws_neuron_venv_pytorch/bin/activate
python ${APPS_PATH}/neuronx-nemo-megatron/nemo/scripts/nlp_language_modeling/preprocess_data_for_megatron.py \
    --input=${DATA_PATH}/book.jsonl \
    --json-keys=text \
    --tokenizer-library=huggingface \
    --tokenizer-type=${MODEL_PATH}/Llama2-7b-hf \
    --dataset-impl=mmap \
    --output-prefix=${DATA_PATH}/book-tokenized \
    --append-eod \
    --need-pad-id \
    --workers=128
