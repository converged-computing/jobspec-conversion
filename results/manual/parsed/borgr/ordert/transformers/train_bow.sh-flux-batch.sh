#!/bin/bash
#FLUX: --job-name=loopy-banana-7676
#FLUX: -t=604800
#FLUX: --urgency=16

lshw -C display | tail # write the acquired gpu properties
lang=en
data_dir=/cs/labs/daphna/guy.hacohen/borgr/ordert/data
train_path=${data_dir}/train.$lang
eval_path=${data_dir}/replica_val.$lang
blimp_dir=/cs/snapless/oabend/borgr/ordert/blimp
model_base=gpt2Small
config="/cs/snapless/oabend/borgr/ordert/configs/${model_base}.json"
model_base=bowgpt
model_name=${model_base}$1
working_dir=/cs/snapless/oabend/borgr/ordert/transformers/
script_path=${working_dir}borgr_code/run_language_modeling_with_tokenizers.py
module load tensorflow/2.0.0
source /cs/snapless/oabend/borgr/envs/tg/bin/activate
cd /cs/snapless/oabend/borgr/ordert/transformers
continue_training=""
if [ -d $working_dir/output/$model_name ]; then
  continue_training=" --overwrite_output_dir " # --should_continue
fi
python $script_path $continue_training \
    --eval_blimp \
    --blimp_dir $blimp_dir\
    --per_gpu_eval_batch_size 4 \
    --train_data_file $train_path \
    --eval_data_file $eval_path \
    --evaluate_during_training \
    --tokenizer_batch_size 100000 \
    --output_dir $working_dir/output/$model_name \
    --model_type bowgpt \
    --do_train \
    --do_eval \
    --line_by_line \
    --learning_rate 1e-5 \
    --num_train_epochs 5 \
    --save_total_limit 20 \
    --tokenizer_name $working_dir/tokenizers/en_tokenizer_gpt2_32k \
    --save_steps 5000 \
    --per_gpu_train_batch_size 4 \
    --warmup_steps=10000 \
    --logging_steps=5000 \
    --gradient_accumulation_steps=4 \
    --config_name $config \
    --block_size=512 # block_size <= n_positions in the config file
