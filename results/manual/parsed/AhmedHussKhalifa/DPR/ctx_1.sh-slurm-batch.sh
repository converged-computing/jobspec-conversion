#!/bin/bash
#SBATCH --output=%N-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:1
#SBATCH --mem=32G
#SBATCH --time=06:00:00

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
