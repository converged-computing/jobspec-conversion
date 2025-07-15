#!/bin/bash
#FLUX: --job-name=boopy-platanos-2481
#FLUX: -c=4
#FLUX: --gpus-per-task=1
#FLUX: --priority=16

PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:64 pasero-decode $@
