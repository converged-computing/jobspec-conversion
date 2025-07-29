#!/bin/bash
#FLUX: --job-name=longf-tune
#FLUX: -n=6
#FLUX: --queue=a100
#FLUX: -t=259200
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='$(ncvd)'
export TOKENIZERS_PARALLELISM='false'
export WANDB_DIR='/scratch/nrmyas001'

module load software/TensorFlow-A100-GPU
export CUDA_VISIBLE_DEVICES=$(ncvd)
export TOKENIZERS_PARALLELISM=false
export WANDB_DIR=/scratch/nrmyas001
cd /home/nrmyas001/clinical-longformer
python3 /home/nrmyas001/.local/bin/wandb agent yass/clinical-longformer/gki8xgk1 \
    2>&1 | tee /scratch/nrmyas001/logs/longf-tune/$(hostname)$(openssl rand -hex 4).out
