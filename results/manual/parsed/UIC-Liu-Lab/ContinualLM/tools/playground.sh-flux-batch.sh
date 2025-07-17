#!/bin/bash
#FLUX: --job-name=fat-blackbean-4464
#FLUX: --queue=gpu20
#FLUX: -t=36000
#FLUX: --urgency=16

export HF_DATASETS_CACHE='/sdb/zke4/dataset_cache'
export TRANSFORMERS_CACHE='/sdb/zke4/model_cache'

export HF_DATASETS_CACHE='/sdb/zke4/dataset_cache'
export TRANSFORMERS_CACHE='/sdb/zke4/model_cache'
CUDA_VISIBLE_DEVICES=3 python playground.py
