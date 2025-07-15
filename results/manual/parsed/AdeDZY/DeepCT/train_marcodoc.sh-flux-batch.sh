#!/bin/bash
#FLUX: --job-name=cowy-noodle-4432
#FLUX: -t=86400
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/opt/cuda/10.0/lib64:/opt/cudnn/cuda-10.0/7.3/cuda/lib64'
export BERT_BASE_DIR='/bos/usr0/zhuyund/uncased_L-12_H-768_A-12'
export TRAIN_DATA_FILE='./data/marco/myalltrain.relevant.docterm_recall'
export OUTPUT_DIR='./output/marco/'

source activate /bos/usr0/zhuyund/tf_env 
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/cuda/10.0/lib64:/opt/cudnn/cuda-10.0/7.3/cuda/lib64
export BERT_BASE_DIR=/bos/usr0/zhuyund/uncased_L-12_H-768_A-12
export TRAIN_DATA_FILE=./data/marco/myalltrain.relevant.docterm_recall
export OUTPUT_DIR=./output/marco/
python run_deepct.py \
  --task_name=marcodoc \
  --do_train=true \
  --do_eval=false \
  --do_predict=false \
  --data_dir=$TRAIN_DATA_FILE \
  --vocab_file=$BERT_BASE_DIR/vocab.txt \
  --bert_config_file=$BERT_BASE_DIR/bert_config.json \
  --init_checkpoint=$BERT_BASE_DIR/bert_model.ckpt \
  --max_seq_length=128 \
  --train_batch_size=16 \
  --learning_rate=2e-5 \
  --num_train_epochs=3.0 \
  --recall_field=title \
  --output_dir=$OUTPUT_DIR
