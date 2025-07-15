#!/bin/bash
#FLUX: --job-name=infer
#FLUX: -c=2
#FLUX: -t=3599
#FLUX: --priority=16

export TRANSFORMERS_CACHE='/scratch/bc3194/huggingface_cache'
export HF_HOME='/scratch/bc3194/huggingface_cache'

module purge
MODEL=5
NUM_LOOPS=10
source ~/.bashrc
conda activate wizard
export TRANSFORMERS_CACHE="/scratch/bc3194/huggingface_cache"
export HF_HOME="/scratch/bc3194/huggingface_cache"
python -u wizardcoder_infer.py
