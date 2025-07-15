#!/bin/bash
#FLUX: --job-name=bactrian_bloom_7b_eval
#FLUX: -c=4
#FLUX: -t=43200
#FLUX: --priority=16

cd /l/users/haonan.li/mygit/CMMLU/src
for i in {0..5}; do
python gpt_model.py \
    --model_name_or_path bigscience/bloom-7b1 \
    --lora_weights MBZUAI/bactrian-x-bloom-7b1-lora \
    --load_in_8bit \
    --save_dir ../results/Bactrian-BLOOM-7B \
    --max_length 768 \
    --num_few_shot $i
done
