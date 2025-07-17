#!/bin/bash
#FLUX: --job-name=DrBERT
#FLUX: -c=24
#FLUX: --queue=gpu_p2
#FLUX: -t=68400
#FLUX: --urgency=16

module purge
module load pytorch-gpu/py3/1.11.0
nvidia-smi
srun python preprocessing_dataset.py \
    --model_type='camembert' \
    --tokenizer_name='./Tokenizer/' \
    --train_file='./data/corpus.txt' \
    --do_train \
    --overwrite_output_dir \
    --max_seq_length=512 \
    --log_level='info' \
    --logging_first_step='True' \
    --cache_dir='./cache_dir/' \
    --path_save_dataset="./data/tokenized_dataset" \
    --output_dir='./test' \
    --preprocessing_num_workers=20
