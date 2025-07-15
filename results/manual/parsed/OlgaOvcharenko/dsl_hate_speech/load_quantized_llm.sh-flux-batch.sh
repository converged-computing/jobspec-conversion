#!/bin/bash
#FLUX: --job-name=stanky-leopard-5502
#FLUX: -c=10
#FLUX: -t=3600
#FLUX: --priority=16

export WANDB__SERVICE_WAIT='300'
export TRANSFORMERS_CACHE='/cluster/scratch/oovcharenko/dsl_hate_speech/cache/'

CONSUL_HTTP_ADDR=""
mkdir -p logs
module load eth_proxy gcc/11.4.0 python/3.11.6 cuda/12.1.1 
source ".venv_llama/bin/activate"
export WANDB__SERVICE_WAIT=300
export TRANSFORMERS_CACHE=/cluster/scratch/oovcharenko/dsl_hate_speech/cache/
nvidia-smi
python src/scripts/save_models_locally.py
