#!/bin/bash
#FLUX: --job-name=mae_224_test
#FLUX: --queue=gpu
#FLUX: -t=28800
#FLUX: --urgency=16

export PATH='/blue/guralnick/rafe.lafrance/.conda/envs/vitmae/bin:$PATH'

date;hostname;pwd
module purge all
export PATH=/blue/guralnick/rafe.lafrance/.conda/envs/vitmae/bin:$PATH
python3 /blue/guralnick/rafe.lafrance/transformers/examples/pytorch/image-pretraining/run_mae.py \
  --train_dir train.csv \
  --validation_dir validation.csv \
  --output_dir /blue/guralnick/rafe.lafrance/phenobase/data/output \
  --dataset_name /blue/guralnick/rafe.lafrance/phenobase/data/mae_splits_224 \
  --remove_unused_columns False \
  --label_names pixel_values \
  --do_train \
  --do_eval \
  --model_name_or_path /blue/guralnick/rafe.lafrance/phenobase/data/output/checkpoint-500
date
