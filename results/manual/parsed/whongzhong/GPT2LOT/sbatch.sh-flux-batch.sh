#!/bin/bash
#FLUX: --job-name=expressive-salad-8260
#FLUX: -c=4
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0'
export PYTHONPATH='.'

source ~/.bashrc
conda activate lot
export CUDA_VISIBLE_DEVICES=0
export PYTHONPATH=.
python main.py \
    --epoch_num 20 \
    --train_batch_size 8 \
    --val_batch_size 32 \
    --eos_token '<eod>' \
    --bos_token '<eod>' \
    --delimeter_token '<DELIMETER>' \
    --sep_token '<sep>' \
    --pad_token '[PAD]' \
    --model_name 'CPM' \
    --max_length '512' \
    --model_path "mymusise/CPM-Generate-distill"\
    --data_root './LOTdatasets/orderd'
    --ckpt_dir 'ckpts/orderd_model'
    #--data_root './LOTdatasets/outgen/board/data'
