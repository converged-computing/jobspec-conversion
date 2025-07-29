#!/bin/bash
#SBATCH --output=logs/%x_%u_%j.out
#SBATCH --error=logs/%x_%u_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=4096

python task_a.py \
    --mode symmetric \
    --output_path "outputs_task_symmetric/" \
    --dataset_path "$1" \
    --train_size 0.6 \
    --val_size 1.0 \
    --random_subset True \
	--image_encoder resnet_18 \
    --text_encoder bert \
    --embedding_size 256 \
	--batch_size 64 \
    --epochs 15 \
    --lr 0.0001 \
    --weight_decay 0.0001
