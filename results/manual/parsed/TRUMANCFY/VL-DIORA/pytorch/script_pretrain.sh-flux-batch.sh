#!/bin/bash
#FLUX: --job-name=goodbye-lettuce-7777
#FLUX: -c=5
#FLUX: --urgency=16

export MASTER_ADDR='127.0.0.1'
export MASTER_PORT='8098'
export NODE_RANK='0'
export PYTHONPATH='/itet-stor/fencai/net_scratch/diora/pytorch/:$PYTHONPATH'

export MASTER_ADDR="127.0.0.1"
export MASTER_PORT="8098"
export NODE_RANK=0
/bin/echo Running on host: `hostname`
/bin/echo In directory: `pwd`
/bin/echo Starting on: `date`
/bin/echo SLURM_JOB_ID: $SLURM_JOB_IdD
set -o errexit
source /itet-stor/fencai/net_scratch/anaconda3/bin/activate diora
export PYTHONPATH=/itet-stor/fencai/net_scratch/diora/pytorch/:$PYTHONPATH
srun python -m torch.distributed.launch --nproc_per_node=1 diora/scripts/pretrain.py \
    --arch mlp-shared \
    --batch_size 64 \
    --data_type partitwhole \
    --bert_cache_dir ./data/bert \
    --emb bert \
    --hidden_dim 400 \
    --k_neg 100 \
    --log_every_batch 100 \
    --lr 2e-3 \
    --normalize unit \
    --reconstruct_mode '' \
    --save_after 500 \
    --train_filter_length 20 \
    --train_path './data/partit_data/{}/train' \
    --validation_path './data/partit_data/{}/test' \
    --cuda --multigpu \
    --max_epoch 10 \
    --master_port 29500 \
    --word2idx './data/partit_data/partnet.dict.pkl' \
    --tokenizer_saving_path './data/bert/toks/' \
    --bertmodel_saving_path './data/bert/model/'
    # --local_rank 0
echo finished at: `date`
exit 0;
