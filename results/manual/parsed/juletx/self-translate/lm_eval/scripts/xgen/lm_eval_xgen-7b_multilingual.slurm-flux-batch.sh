#!/bin/bash
#FLUX: --job-name=lm_eval_xgen-7b_multilingual
#FLUX: -c=8
#FLUX: -t=0
#FLUX: --urgency=16

export TRANSFORMERS_CACHE='/gaueko0/transformers_cache/'
export TOKENIZERS_PARALLELISM='false'

source /gaueko0/users/jetxaniz007/phd/venv2/bin/activate
export TRANSFORMERS_CACHE="/gaueko0/transformers_cache/"
export TOKENIZERS_PARALLELISM=false
model_names=(
    "Salesforce/xgen-7b-8k-base"
    "Salesforce/xgen-7b-4k-base"
    "Salesforce/xgen-7b-8k-inst"
)
source ../tasks.sh
tasks_selected=(
    #"xcopa"
    #"xstory_cloze"
    #"xwinograd"
    "pawsx"
    "xnli"
)
num_fewshot=0
for model_name in "${model_names[@]}"; do
    for group_name in "${tasks_selected[@]}"; do
        srun python3 ../../lm-evaluation-harness/main.py \
            --model hf-causal-experimental \
            --model_args pretrained=$model_name,dtype=bfloat16,trust_remote_code=True \
            --tasks ${tasks[${group_name}]} \
            --device cuda \
            --output_path ../../results/xgen/${model_name:11}/${model_name:11}_${group_name}_${num_fewshot}-shot.json \
            --batch_size auto \
            --no_cache \
            --num_fewshot ${num_fewshot}
    done
done
