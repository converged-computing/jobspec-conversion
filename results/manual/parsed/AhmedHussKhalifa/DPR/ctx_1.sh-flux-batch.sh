#!/bin/bash
#FLUX: --job-name=fugly-punk-6970
#FLUX: -t=21600
#FLUX: --urgency=16

module load python/3.6.3
source virtual_DPR/bin/activate
mkdir data/embedding_1
time python generate_dense_embeddings.py \
  --model_file 'data/checkpoint/hf_bert_base.cp' \
  --ctx_file '/ctx_file/CAR_collection_1.tsv' \
  --shard_id  1 \
  --num_shards 10\
  --batch_size 128 \
  --out_file 'data/embedding_1'
