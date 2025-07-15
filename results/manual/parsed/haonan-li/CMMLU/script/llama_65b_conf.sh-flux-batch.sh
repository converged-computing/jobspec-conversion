#!/bin/bash
#FLUX: --job-name=llama_65b_eval
#FLUX: -c=4
#FLUX: -t=43200
#FLUX: --urgency=16

cd ../src
for i in {0..1}; do
python hf_causal_model.py \
    --model_name_or_path huggyllama/llama-65b \
    --save_dir ../results/LLaMA-65B-conf \
    --load_in_8bit \
    --with_conf \
    --num_few_shot $i
done
