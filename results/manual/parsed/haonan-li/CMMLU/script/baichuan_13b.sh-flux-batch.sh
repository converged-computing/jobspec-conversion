#!/bin/bash
#FLUX: --job-name=baichuan_13b_eval
#FLUX: -c=4
#FLUX: -t=43200
#FLUX: --urgency=16

cd ../src
for i in {0..5}; do
python hf_causal_model.py \
    --model_name_or_path baichuan-inc/Baichuan-13B-Base \
    --save_dir ../results/Baichuan-13B-Base \
    --num_few_shot $i
done
