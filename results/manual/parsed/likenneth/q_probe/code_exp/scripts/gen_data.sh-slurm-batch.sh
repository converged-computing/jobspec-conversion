#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=200GB
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-20

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
