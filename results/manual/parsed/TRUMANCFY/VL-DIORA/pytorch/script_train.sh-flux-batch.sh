#!/bin/bash
#FLUX: --job-name=angry-chip-0636
#FLUX: -c=5
#FLUX: --urgency=16

export MASTER_ADDR='127.0.0.1'
export MASTER_PORT='8091'
export NODE_RANK='0'
export PYTHONPATH='/itet-stor/fencai/net_scratch/diora/pytorch/:$PYTHONPATH'

export MASTER_ADDR="127.0.0.1"
export MASTER_PORT="8091"
export NODE_RANK=0
/bin/echo Running on host: `hostname`
/bin/echo In directory: `pwd`
/bin/echo Starting on: `date`
/bin/echo SLURM_JOB_ID: $SLURM_JOB_IdD
set -o errexit
source /itet-stor/fencai/net_scratch/anaconda3/bin/activate diora
export PYTHONPATH=/itet-stor/fencai/net_scratch/diora/pytorch/:$PYTHONPATH
srun python -m torch.distributed.launch --nproc_per_node=1 diora/scripts/train.py \
    --arch mlp-shared \
    --batch_size 32 \
    --data_type partit \
    --elmo_cache_dir ./data/elmo \
    --emb elmo \
    --hidden_dim 512 \
    --k_neg 100 \
    --log_every_batch 100 \
    --reconstruct_mode softmax \
    --lr 2e-3 \
    --normalize unit \
    --save_after 50 \
    --train_filter_length 20 \
    --train_path './data/partit_data/3.bag/train' \
    --validation_path './data/partit_data/3.bag/test' \
    --cuda \
    --max_epoch 100 \
    --master_port 29500 \
    --word2idx './data/partit_data/partnet.dict.pkl'
    # --local_rank 0
echo finished at: `date`
exit 0;
