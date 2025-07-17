#!/bin/bash
#FLUX: --job-name=run-detect
#FLUX: -n=4
#FLUX: --queue=scavenger
#FLUX: -t=86400
#FLUX: --urgency=16

source ~/.bashrc
conda activate watermarking-dev
model_name='/cmlscratch/manlis/test/watermarking-root/local_model/llama-7b-base'
mask_model="t5-3b"
chunk_size=32 # can run 32 when textlen=200
pct=0.3
split='no_wm_paraphrase'
declare -a commands
for textlen in 50 100 200;
do
    commands+=( "python detectgpt_main.py \
        --n_perturbation_list='100' \
        --do_chunk \
        --base_model_name=${model_name} \
        --mask_filling_model_name=${mask_model} \
        --filter='null' \
        --data_path=/cmlscratch/manlis/test/watermarking-root/input/core_simple_1_200_1000_no_wm_gpt_p4_prefixes/gen_table_prefixes_${textlen}.jsonl \
        --token_len=${textlen} \
        --pct_words_masked=${pct} \
        --chunk_size=${chunk_size} \
        --data_split=${split};" )
done
bash -c "${commands[${SLURM_ARRAY_TASK_ID}]}"
