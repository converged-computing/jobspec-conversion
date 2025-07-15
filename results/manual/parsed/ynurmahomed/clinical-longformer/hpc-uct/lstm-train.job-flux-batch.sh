#!/bin/bash
#FLUX: --job-name=lstm-train
#FLUX: -n=6
#FLUX: --queue=a100
#FLUX: -t=3600
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='$(ncvd)'
export WANDB_DIR='/scratch/nrmyas001/wandb'

module load software/TensorFlow-A100-GPU
export CUDA_VISIBLE_DEVICES=$(ncvd)
export WANDB_DIR=/scratch/nrmyas001/wandb
for d in 0.1 0.2 0.3
do
python -m src.clinical_longformer.model.lstm  \
    /scratch/nrmyas001/datasets/discharge/-1 \
    --do_train \
    --vectors_root=/scratch/nrmyas001/data \
    --default_root_dir=/scratch/nrmyas001/data/model/LSTM \
    --max_epochs=10 \
    --dropout=$d \
    --num_workers=6 \
    --precision=16 \
    --gpus=1 2>&1 | tee /scratch/nrmyas001/logs/lstm-train/$(hostname)$(openssl rand -hex 4).out
done
