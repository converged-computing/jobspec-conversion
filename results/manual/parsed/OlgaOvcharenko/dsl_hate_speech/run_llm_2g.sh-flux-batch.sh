#!/bin/bash
#FLUX: --job-name=evasive-animal-5850
#FLUX: -c=10
#FLUX: -t=172800
#FLUX: --priority=16

export WANDB__SERVICE_WAIT='300'
export TRANSFORMERS_CACHE='/cluster/scratch/oovcharenko/dsl_hate_speech/cache/'

CONSUL_HTTP_ADDR=""
mkdir -p logs
mkdir -p outputs
mkdir -p outputs_targets
mkdir -p data/llm_target
mkdir -p outputs_targets_new
mkdir -p outputs_targets_new/tokenizer
mkdir -p outputs_targets_new/model
mkdir -p outputs_targets_mistral
mkdir -p data/llm_target_predict
module load eth_proxy gcc/11.4.0 python/3.11.6 cuda/12.1.1 
source ".venv_llama/bin/activate"
export WANDB__SERVICE_WAIT=300
export TRANSFORMERS_CACHE=/cluster/scratch/oovcharenko/dsl_hate_speech/cache/
echo "$(date)"
echo "$1"
nvidia-smi
python "$1"
echo "$(date)"
