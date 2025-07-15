#!/bin/bash
#FLUX: --job-name=fugly-pedo-0572
#FLUX: --urgency=16

module purge;
module load anaconda3/5.3.0;
source activate secenv;
python model2/run_model_seq.py \
        --model_name_or_path '/scratch/uananthe/thesis/multitask4mixbiverbose2_prin_maven_1024_20_1bs_2DAYS' \
        --do_train false \
        --do_predict true \
        --train_file "/scratch/uananthe/EventEx_data/multitask4mix_bi_verbose2/trainmaven.csv" \
        --test_file "/scratch/uananthe/EventEx_data/multitask4mix_bi_verbose2/testmaven.csv" \
        --output_dir "/scratch/uananthe/thesis/multitask4mixbiverbose2_prin_maven_1024_20_bs50_seq3_1bs_2DAYS" \
        --overwrite_output_dir true \
        --num_train_epochs="100" \
        --max_source_length="1024" \
        --text_column="text_in" \
        --summary_column="src_label" \
        --per_device_train_batch_size="1" \
        --per_device_eval_batch_size="1" \
        --predict_with_generate \
        --save_strategy="steps" \
        --num_beams="50" \
        --num_return_sequences="3" #\
