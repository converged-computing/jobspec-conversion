#!/bin/bash
#FLUX: --job-name=lm_eval_falcon-40b_mgsm
#FLUX: -c=8
#FLUX: -t=0
#FLUX: --priority=16

export TRANSFORMERS_CACHE='/gaueko0/transformers_cache/'
export TOKENIZERS_PARALLELISM='false'
export CUDA_VISIBLE_DEVICES='4,5'

source /gaueko0/users/jetxaniz007/phd/venv2/bin/activate
export TRANSFORMERS_CACHE="/gaueko0/transformers_cache/"
export TOKENIZERS_PARALLELISM=false
export CUDA_VISIBLE_DEVICES=4,5
model_names=(
    "tiiuae/falcon-40b"
)
source ../tasks.sh
tasks_selected=(
    "mgsm"
)
num_fewshot=8
for model_name in "${model_names[@]}"; do
    for group_name in "${tasks_selected[@]}"; do
        python3 ../../lm-evaluation-harness/main.py \
            --model hf-causal-experimental \
            --model_args pretrained=$model_name,use_accelerate=True,trust_remote_code=True,dtype=bfloat16 \
            --tasks ${tasks[${group_name}]} \
            --device cuda \
            --output_path ../../results/falcon/${model_name:7}/${model_name:7}_${group_name}_${num_fewshot}-shot.json \
            --batch_size 6 \
            --no_cache \
            --num_fewshot ${num_fewshot} >> ../.slurm/lm_eval_falcon-40b_mgsm.out 2>> ../.slurm/lm_eval_falcon-40b_mgsm.err
    done
done
