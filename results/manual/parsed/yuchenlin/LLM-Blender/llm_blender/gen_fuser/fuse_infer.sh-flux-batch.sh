#!/bin/bash
#FLUX: --job-name=fuse_infer_3b
#FLUX: -t=28800
#FLUX: --priority=16

model_path="yuchenlin/gen_fuser" # yuchenlin/gen_fuser_3500
model_name="gen_fuser_beam4"
cd ../../
mkdir -p data/mix_128/fuse_gen/predictions/test/${model_name}/
CUDA_VISIBLE_DEVICES=0 python src/fusion_module/fuse_infer.py \
    --model_path $model_path --model_name $model_name \
    --start_index 0 \
    --end_index 5000 \
    --data_path data/mix_128/fuse_gen/test/top3_deberta-bartscore.jsonl \
    --output_file data/mix_128/fuse_gen/predictions/test/${model_name}/top3_deberta-bartscore.output.jsonl \
    --beam_size 4
