#!/bin/bash
#FLUX: --job-name=spicy-mango-8524
#FLUX: -c=4
#FLUX: --gpus-per-task=1
#FLUX: --urgency=16

PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:64 pasero-decode $@
