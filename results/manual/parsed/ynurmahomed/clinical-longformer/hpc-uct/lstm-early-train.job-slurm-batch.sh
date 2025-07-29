#!/bin/bash
#FLUX: --job-name=lstm-train
#FLUX: -n=6
#FLUX: --queue=a100
#FLUX: -t=900
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='$(ncvd)'
export WANDB_DIR='/scratch/nrmyas001/wandb'
export WANDB_ENTITY='yass'
export WANDB_PROJECT='clinical-longformer'
export WANDB_NAME='LSTM-early'

module load software/TensorFlow-A100-GPU
export CUDA_VISIBLE_DEVICES=$(ncvd)
export WANDB_DIR=/scratch/nrmyas001/wandb
export WANDB_ENTITY=yass
export WANDB_PROJECT=clinical-longformer
export WANDB_NAME=LSTM-early
python -m src.clinical_longformer.model.lstm \
    /scratch/nrmyas001/datasets/all7days/all/-1/7days/ \
    --do_train \
    --vectors_root=/scratch/nrmyas001/data \
    --default_root_dir=/scratch/nrmyas001/data/model/LSTM-early \
    --max_epochs=10 \
    --lr=8e-4 \
    --batch_size=64 \
    --embed_dim=300 \
    --hidden_dim=200 \
    --num_workers=6 \
    --precision=16 \
    --gpus=1 2>&1 | tee /scratch/nrmyas001/logs/lstm-train/$(hostname)$(openssl rand -hex 4).out
