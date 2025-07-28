#!/bin/bash
#FLUX: --job-name=label_data
#FLUX: -c=6
#FLUX: --queue=gpu
#FLUX: -t=14400
#FLUX: --urgency=16

export HF_DATASETS_CACHE='/scratch/$USER/.cache/huggingface/datasets'
export TRANSFORMERS_CACHE='/scratch/$USER/.cache/huggingface/transformers'
export XDG_CACHE_HOME='/scratch/$USER/.cache'

module purge
module load Python/3.10.4-GCCcore-11.3.0
source $HOME/.envs/rude_nmt/bin/activate
module load PyTorch/1.12.1-foss-2022a-CUDA-11.7.0
export HF_DATASETS_CACHE="/scratch/$USER/.cache/huggingface/datasets"
export TRANSFORMERS_CACHE="/scratch/$USER/.cache/huggingface/transformers"
export XDG_CACHE_HOME="/scratch/$USER/.cache"
python -u main.py --data tatoeba --label_data --use_ds tatoeba_merged --force_regenerate
