#!/bin/bash
#FLUX --job-name=butterscotch-citrus-9448
#FLUX --queue=gpu20
#FLUX -t=36000
#FLUX --urgency=16

export HF_DATASETS_CACHE='/sdb/zke4/dataset_cache'
export TRANSFORMERS_CACHE='/sdb/zke4/model_cache'

export HF_DATASETS_CACHE='/sdb/zke4/dataset_cache'
export TRANSFORMERS_CACHE='/sdb/zke4/model_cache'
CUDA_VISIBLE_DEVICES=3 python playground.py
