#!/bin/bash
#FLUX: --job-name=crunchy-lemon-8933
#FLUX: -n=14
#FLUX: --queue=nvidia
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
source ~/.bashrc
source activate tensorflow-1.15
python run_pretraining.py \
  --input_file=./train2.tfrecord \
  --output_dir=./output \
  --do_train=True \
  --do_eval=True \
  --bert_config_file=./config.json \
  --init_checkpoint= /scratch/nx296/kaggle/news/pretrain/output/bert_model.ckpt \
  --train_batch_size=128 \
  --max_seq_length=256 \
  --max_predictions_per_seq=32 \
  --num_train_steps=315000 \
  --num_warmup_steps=10 \
  --learning_rate=2e-5> log/ptrain.log 2>&1
