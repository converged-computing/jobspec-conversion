#!/bin/bash
#FLUX: --job-name=openai_vllm
#FLUX: -c=72
#FLUX: --queue=GPU4v100
#FLUX: -t=259200
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0,1,2,3'

set -x
module load cuda121
source activate vllm-env
export CUDA_VISIBLE_DEVICES=0,1,2,3
srun --cpus-per-task 72 python -m vllm.entrypoints.openai.api_server \
  --model /archive/shared/sim_center/shared/mixtral/data/Mixtral-8x7B-Instruct-v0.1 \
  --chat-template /archive/shared/sim_center/shared/mixtral/vllm/template_mistral.jinja \
  --trust-remote-code --dtype float16 --tensor-parallel-size 4 --max-model-len 8192
