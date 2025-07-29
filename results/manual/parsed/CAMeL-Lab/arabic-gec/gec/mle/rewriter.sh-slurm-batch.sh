#!/bin/bash
#SBATCH --output=job.%J.out
#SBATCH --error=job.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --time=1-16:00:00
#SBATCH --partition=nvidia

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
