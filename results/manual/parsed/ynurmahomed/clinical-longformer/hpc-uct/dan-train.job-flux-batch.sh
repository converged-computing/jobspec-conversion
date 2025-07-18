#!/bin/bash
#FLUX: --job-name=dan-train
#FLUX: -n=6
#FLUX: --queue=a100
#FLUX: -t=600
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='$(ncvd)'
export WANDB_DIR='/scratch/nrmyas001/wandb'

module load software/TensorFlow-A100-GPU
export CUDA_VISIBLE_DEVICES=$(ncvd)
export WANDB_DIR=/scratch/nrmyas001/wandb
for i in {1}
do
python -m src.clinical_longformer.model.dan  \
    /scratch/nrmyas001/datasets/discharge/-1 \
    --do_train \
    --vectors_root=/scratch/nrmyas001/data \
    --default_root_dir=/scratch/nrmyas001/data/model/DAN \
    --batch_size=64 \
    --embed_dim=100 \
    --lr=7e-4 \
    --num_hidden=2 \
    --p=0.6 \
    --weight_decay=1e-2 \
    --max_epochs=10 \
    --num_workers=6 \
    --gpus=1 2>&1 | tee /scratch/nrmyas001/logs/dan-train/$(hostname)$(openssl rand -hex 4).out
done
