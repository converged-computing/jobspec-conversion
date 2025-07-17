#!/bin/bash
#FLUX: --job-name=BERT_Agave
#FLUX: -n=24
#FLUX: --queue=wildfire
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='24'

export OMP_NUM_THREADS=24
module load anaconda3/5.3.0
python3 bert_covid.py --data_dir=./data --bert_model=bert-base-uncased --output_dir=./output_128 --max_seq_length=128 --num_train_epochs=10 --do_eval --train_batch_size=8 --eval_batch_size=1
