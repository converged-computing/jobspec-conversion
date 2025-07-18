#!/bin/bash
#FLUX: --job-name=eccentric-fork-2734
#FLUX: -t=0
#FLUX: --urgency=16

module load singularity
singularity shell --nv /projects/tir1/singularity/ubuntu-16.04-lts_tensorflow-1.4.0_cudnn-8.0-v6.0.img
python src/main.py \
  --clean_mem_every=5 \
  --output_dir="outputs_exp5_v3" \
  --log_every=100 \
  --eval_every=2000 \
  --reset_output_dir \
  --no_load_model \
  --data_path="data/clean_piece_37k_shared/en-de/" \
  --source_train="train.en" \
  --target_train="train.de" \
  --source_valid="dev2010.en" \
  --target_valid="dev2010.de" \
  --source_vocab="vocab.en" \
  --target_vocab="vocab.de" \
  --source_test="tst2014.en" \
  --target_test="tst2014.de" \
  --share_emb_and_softmax \
  --cuda \
  --batch_size=128 \
  --n_train_sents=250000 \
  --max_len=300 \
  --d_word_vec=288 \
  --d_model=288 \
  --d_inner=507 \
  --n_layers=5 \
  --d_k=64 \
  --d_v=64 \
  --n_heads=2 \
  --n_train_steps=200000 \
  --n_warm_ups=746 \
  --dropout=0.12 \
  --lr_adam=0.0005 \
  --lr_sgd=0.25 \
  --optim_switch=50000 \
  --lr_dec=1.1 \
  --init_range=0.04 \
  --grad_bound=5.0 \
  "$@"
