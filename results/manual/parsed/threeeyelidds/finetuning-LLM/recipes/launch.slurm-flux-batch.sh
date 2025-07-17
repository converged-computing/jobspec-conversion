#!/bin/bash
#FLUX: --job-name=pendulum-llama
#FLUX: --queue=general
#FLUX: -t=3600
#FLUX: --urgency=16

export CUDA_HOME='/usr/local/cuda-12.2/'
export PYTHONUNBUFFERED='1'
export HF_TOKEN='hf_xxxxxxxxxxxxxxxxxxxxxxxxxxxxx'

nvidia-smi
module load cuda-12.2
nvcc --version
which nvcc
export CUDA_HOME=/usr/local/cuda-12.2/
export PYTHONUNBUFFERED=1
export HF_TOKEN=hf_xxxxxxxxxxxxxxxxxxxxxxxxxxxxx
python -m pip --version
python --version
python -m pip install -r requirements.txt
echo "START TIME: $(date)"
python src/run_sft.py recipes/model_configs/sft/config_lora_llama.yaml
echo "END TIME: $(date)"
