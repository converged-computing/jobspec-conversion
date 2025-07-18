#!/bin/bash
#FLUX: --job-name=${dataset}-${split}-${SAVE_NAME}-s${seed}
#FLUX: --queue=learnlab
#FLUX: -t=259200
#FLUX: --urgency=16

export dataset='NACS'
export split='length'
export seed='0'
export base_dir='${BASE_DIR}'
export input_path='${base_dir}/data/${dataset}/${split}'
export warmup='0'
export TEST_SPLIT='test'
export output_dir='${base_dir}/trained_models/${dataset}/${split}'
export lr='1e-4'
export gradient_accumulation_steps='8'
export batch_size='25'
export segment='3'
export dev_file_suffix='test'
export train_step='15000'
export eval_step_list='1000 4000 7000 10000 13000 15000'

export dataset="NACS"
export split="length"
export seed=0
export base_dir=${BASE_DIR}
export input_path="${base_dir}/data/${dataset}/${split}"
export warmup=0
export TEST_SPLIT="test"
export output_dir=${base_dir}/trained_models/${dataset}/${split}
export lr=1e-4
export gradient_accumulation_steps=8
export batch_size=25
export segment=3
export dev_file_suffix=test
export train_step=15000
export eval_step_list="1000 4000 7000 10000 13000 15000"
if [[ $dataset == *"geoquery"* ]]
then
    export vocab_size=200
    export lr=1e-5
    export max_source_length=64
    export max_target_length=64
elif [[ $dataset == *"SCAN"* ]]
then
    export vocab_size=100
    export max_source_length=128
    export max_target_length=128
    export train_step=10000
    export segment=1
    export eval_step_list="1000 4000 7000 10000"
elif [[ $dataset == *"NACS"* ]]
then
    export vocab_size=100
    export max_source_length=128
    export max_target_length=128
    export train_step=10000
    export segment=1
    export eval_step_list="1000 4000 7000 10000"
    # export lr=5e-5
    export lr=1e-5
elif [[ $dataset == *"spider"* ]]
then
    export vocab_size=800
    export max_source_length=128
    export max_target_length=128
    export gradient_accumulation_steps=32
    export batch_size=32
    export train_step=15000
    export warmup=2000
    export segment=1
elif [[ $dataset == *"COGS"* ]]
then
    export vocab_size=400
    export lr=1e-4
    export max_source_length=64
    export max_target_length=64
    if [[ $split != *"length"* ]]
    then
        export dev_file_suffix=dev
    fi
fi
SAVE_NAME=btg_${seed}         # Checkpoint name
sbatch <<EOT
module load anaconda3/2022.05
module load cuda
source "/private/home/kaisersun/.bashrc"
cd $base_dir/baseline_replication/btg-seq2seq
conda activate btg-seq2seq
    CUDA_VISIBLE_DEVICES=0	 python neural_btg/commands/train_nmt_seg2seg.py \
        --do_train \
        --do_eval \
        --do_test \
        --use_posterior \
        --seed $seed \
        --train_filename $base_dir/data/${dataset}/${split}_split/btg_source_train.txt,${base_dir}/data/${dataset}/${split}_split/btg_target_train.txt \
        --dev_filename ${base_dir}/data/${dataset}/${split}_split/btg_source_${dev_file_suffix}.txt,${base_dir}/data/${dataset}/${split}_split/btg_target_${dev_file_suffix}.txt \
        --output_dir $output_dir/$SAVE_NAME \
        --max_source_length $max_source_length \
        --max_target_length $max_target_length \
        --vocab_size $vocab_size \
        --num_segments $segment \
        --geo_p 0.6 \
        --num_segre_samples 1 \
        --max_source_segment_length 4 \
        --max_target_segment_length 4 \
        --gradient_accumulation_steps $gradient_accumulation_steps  \
        --eval_step_list ${eval_step_list} \
        --beam_size 10 \
        --train_batch_size ${batch_size} \
        --eval_batch_size ${batch_size} \
        --learning_rate $lr \
        --warmup_steps $warmup \
        --train_steps $train_step \
        --eval_steps 600
    # Copy the prediction file to pred
    cp $output_dir/$SAVE_NAME/dev_${train_step}.output ${BASE_DIR}/preds/${dataset}/${split}/btg_${seed}_test.txt
EOT
