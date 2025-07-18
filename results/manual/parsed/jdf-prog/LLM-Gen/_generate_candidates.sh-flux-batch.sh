#!/bin/bash
#FLUX: --job-name=generate_candidates
#FLUX: -t=86400
#FLUX: --urgency=16

nvidia-smi
dataset=$1
set=$2
model=$3
prompt_max_length=$4
output_max_length=$5
start_idx=$6
end_idx=$7
data_dor="./data"
cache_dir="/home/dongfu/WorkSpace/LLM-Blender/hf_models" # specify your huggingface cache dir or "" for default cache dir
dtype="float16"
decoding_method="top_p_sampling"
num_candidates=1
num_beams=$num_candidates
num_beam_groups=$num_candidates
overwrite=False
inference_bs=3
temperature=0.7
no_repeat_ngram_size=0
repetition_penalty=1.0
top_p=1.0
if [ -z "$prompt_max_length" ]; then
    prompt_max_length=512
    echo "prompt_max_length is not provided, set to $prompt_max_length"
else
    echo "prompt_max_length: $prompt_max_length"
fi
if [ -z "$output_max_length" ]; then
    output_max_length=512
    echo "output_max_length is not provided, set to $output_max_length"
else
    echo "output_max_length: $output_max_length"
fi
if [ -z "$start_idx" ] && [ -z "$end_idx" ]; then
    echo "start_idx and end_idx are not provided, set to None"
else
    echo "start_idx: $start_idx"
    echo "end_idx: $end_idx"
fi
/home/dongfu/.conda/envs/llm_reranker/bin/python generate_candidates.py \
    --model $model \
    --data_dir $data_dor \
    --dataset $dataset \
    --set $set \
    --num_return_sequences $num_candidates \
    --decoding_method $decoding_method \
    --inference_bs $inference_bs \
    --prompt_max_length $prompt_max_length \
    --output_max_length $output_max_length \
    --dtype $dtype \
    --num_beams $num_beams \
    --num_beam_groups $num_beam_groups \
    --start_idx "$start_idx" \
    --end_idx "$end_idx" \
    --overwrite $overwrite \
    --temperature $temperature \
    --no_repeat_ngram_size $no_repeat_ngram_size \
    --top_p $top_p \
    --repetition_penalty $repetition_penalty \
    --cache_dir "$cache_dir" \
