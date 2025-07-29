#!/bin/bash
#SBATCH --job-name=mae_224_test
#SBATCH --output=/blue/guralnick/rafe.lafrance/phenobase/logs/%x_%j.out
#SBATCH --mail-user=rafe.lafrance@ufl.edu
#SBATCH --mail-type=FAIL,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=a100:1
#SBATCH --mem=8gb
#SBATCH --time=08:00:00
#SBATCH --partition=gpu

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
