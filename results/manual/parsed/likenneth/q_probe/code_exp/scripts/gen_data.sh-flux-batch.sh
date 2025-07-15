#!/bin/bash
#FLUX: --job-name=hanky-chip-5769
#FLUX: -c=16
#FLUX: -t=172800
#FLUX: --priority=16

export CONFIG='generation_configs/$1.yaml'
export TOKENIZERS_PARALLELISM='false'
export PYTORCH_CUDA_ALLOC_CONF='max_split_size_mb:128'

source ~/.bashrc
export CONFIG=generation_configs/$1.yaml
export TOKENIZERS_PARALLELISM=false
export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:128
conda deactivate
conda activate mcts-llm
if [[ "$2" == "debug" ]]; then
  python scripts/gen_data.py config=${CONFIG} debug=True
else
  python scripts/gen_data.py config=${CONFIG} debug=False
fi
