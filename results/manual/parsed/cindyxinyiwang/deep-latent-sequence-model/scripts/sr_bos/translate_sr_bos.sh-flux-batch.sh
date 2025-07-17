#!/bin/bash
#FLUX: --job-name=bloated-mango-2748
#FLUX: -t=0
#FLUX: --urgency=16

export PYTHONPATH='$(pwd)'

export PYTHONPATH="$(pwd)"
python src/translate.py \
  --model_dir $1 \
  --test_src_file $2 \
  --test_trg_file $3 \
  --out_file $4 \
  --beam_size 1 \
  --merge_bpe \
  --cuda \
