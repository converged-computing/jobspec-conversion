#!/bin/bash
#FLUX: --job-name=carnivorous-cat-0903
#FLUX: --queue=nvidia
#FLUX: -t=144000
#FLUX: --urgency=16

train_file=/home/ba63/gec-release/data/ged/areta_tags_camelira/mix/mix_train.areta+.nopnx.txt
test_file=/home/ba63/gec-release/data/ged/areta_tags_camelira/zaebuc/zaebuc_dev.areta+.txt
ged_model=/scratch/ba63/gec/models/ged++/mix/full/w_camelira/checkpoint-5500
output_path=/home/ba63/gec-release/gec/outputs/zaebuc/mle+morph/zaebuc_dev.preds.txt
python rewriter.py \
        --train_file $train_file \
        --test_file  $test_file \
        --ged_model  $ged_model \
        --mode full \
        --cbr_ngrams 2 \
        --output_path $output_path \
        --do_error_ana
