#!/bin/bash
#FLUX: --job-name=outstanding-parsnip-8184
#FLUX: -c=40
#FLUX: --queue=rise
#FLUX: -t=259200
#FLUX: --urgency=16

export PYTHONUNBUFFERED='1'

pwd
hostname
date
echo starting job...
source ~/.bashrc
conda activate pytorch-transformer
export PYTHONUNBUFFERED=1
size_ratio=0.5
CKPT_DIR=/data/yyaoqing/fairseq/checkpoint/roberta_pretrain_wikitext-103_subsample_$size_ratio/
DATA_DIR=/data/yyaoqing/fairseq/data-bin/wikitext-103
LOG_DIR=/home/eecs/yyaoqing/logs/roberta_logs/
srun -N 1 -n 1 --gres=gpu:4 fairseq-hydra-train -m --config-dir examples/roberta/config/pretraining \
--config-name base task.data=$DATA_DIR \
1>$LOG_DIR/train_$size_ratio.log 2>$LOG_DIR/train_$size_ratio.err &
wait
date
