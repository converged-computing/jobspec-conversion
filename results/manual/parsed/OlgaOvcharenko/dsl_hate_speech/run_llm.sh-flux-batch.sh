#!/bin/bash
#FLUX: --job-name=sticky-itch-1116
#FLUX: -c=16
#FLUX: -t=43200
#FLUX: --urgency=16

export WANDB__SERVICE_WAIT='300'
export TRANSFORMERS_CACHE='/cluster/scratch/oovcharenko/dsl_hate_speech/cache/'

CONSUL_HTTP_ADDR=""
mkdir -p logs
module load eth_proxy gcc/11.4.0 python/3.11.6 cuda/12.1.1 
source ".venv_llama/bin/activate"
export WANDB__SERVICE_WAIT=300
export TRANSFORMERS_CACHE=/cluster/scratch/oovcharenko/dsl_hate_speech/cache/
echo "$(date)"
echo "$1"
nvidia-smi
python "$1" &
sleep 122
nvidia-smi
wait
echo "$(date)"
