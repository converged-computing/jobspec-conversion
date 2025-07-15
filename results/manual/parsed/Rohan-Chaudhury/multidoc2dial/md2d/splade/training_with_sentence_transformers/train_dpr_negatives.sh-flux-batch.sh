#!/bin/bash
#FLUX: --job-name=fuzzy-itch-7542
#FLUX: -t=259200
#FLUX: --priority=16

export NCCL_SOCKET_IFNAME='eno1'
export NCCL_IB_DISABLE='1 '

export NCCL_SOCKET_IFNAME=eno1
export NCCL_IB_DISABLE=1 
lambda=0.$SLURM_ARRAY_TASK_ID
echo $lambda
python splade_md2d.py \
    --model_name /home/adityasv/multidoc2dial/md2d/splade/training_with_sentence_transformers/output/distilsplade-ft-dpr/0_MLMTransformer \
    --use_all_queries \
    --data_path /home/adityasv/multidoc2dial/data/mdd_dpr/dpr_negatives_beir_format \
    --lr 1e-6 \
    --epochs 20 \
    --pair_lambda $lambda
