#!/bin/bash
#FLUX: --job-name=swav_100ep_pretrain
#FLUX: -N=8
#FLUX: -c=8
#FLUX: -t=25200
#FLUX: --urgency=16

!/bin/bash
master_node=${SLURM_NODELIST:0:9}${SLURM_NODELIST:10:4}
dist_url="tcp://"
dist_url+=$master_node
dist_url+=:40000
DATADIR=$1
OUTDIR=$2
OUTDIR+='/swav_100ep_pretrain'
mkdir -p $OUTDIR
srun --output=${OUTDIR}/%j.out --error=${OUTDIR}/%j.err --label python -u main_swav.py \
--data_path $DATADIR \
--nmb_crops 2 6 \
--size_crops 224 96 \
--min_scale_crops 0.14 0.05 \
--max_scale_crops 1. 0.14 \
--crops_for_assign 0 1 \
--temperature 0.1 \
--epsilon 0.05 \
--sinkhorn_iterations 3 \
--feat_dim 128 \
--nmb_prototypes 3000 \
--queue_length 0 \
--epochs 100 \
--batch_size 64 \
--base_lr 4.8 \
--final_lr 0.0048 \
--freeze_prototypes_niters 313 \
--wd 0.000001 \
--warmup_epochs 10 \
--start_warmup 0.3 \
--dist_url $dist_url \
--arch resnet50 \
--use_fp16 true \
--sync_bn apex \
--dump_path $OUTDIR
