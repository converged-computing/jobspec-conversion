#!/bin/bash
#FLUX: --job-name=finetune
#FLUX: -c=3
#FLUX: -t=13800
#FLUX: --urgency=16

export WANDB_MODE='offline'

module purge
export WORK
export WANDB_MODE="offline"
module load anaconda-py3/2021.05
conda activate /gpfswork/rech/mdb/urz96ze/miniconda3/envs/Barth
module load pytorch-gpu/py3/1.11.0
set -x
python finetuning.py --train_dir /yourtrain.csv \
                        --test_dir /yourtest.csv \
                        --modelconfig configs/shallow.config.json \
                        --load mymodelpath \
                        --skipMiss \
                        --freeze \
                        --weight_decay 0.1 \
                        --lr 0.00005 \
