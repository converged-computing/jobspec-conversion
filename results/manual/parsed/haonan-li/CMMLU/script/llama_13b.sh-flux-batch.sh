#!/bin/bash
#FLUX: --job-name=llama_13b_eval
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=43200
#FLUX: --urgency=16

cd ../src
for i in {0..5}; do
python hf_causal_model.py \
    --model_name_or_path decapoda-research/llama-13b-hf \
    --save_dir ../results/LLaMA-13B \
    --num_few_shot $i
done
