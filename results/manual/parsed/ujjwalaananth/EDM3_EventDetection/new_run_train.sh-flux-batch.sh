#!/bin/bash
#FLUX: --job-name=sticky-underoos-4544
#FLUX: -n=20
#FLUX: --queue=cidsegpu1_contrib_res
#FLUX: -t=1200
#FLUX: --urgency=16

module purge;
module load anaconda3/5.3.0;
source activate secenv;
python model2/run_model.py \
        --model_name_or_path 't5-base' \
        --do_train true \
        --train_file "data/CASIE_processed/train.csv" \
        --test_file "data/CASIE_processed/test.csv" \
        --output_dir "/scratch/uananthe/thesis/text_ev_casie_512_10_64" \
        --overwrite_output_dir true \
        --num_train_epochs="10" \
        --max_source_length="512" \
        --text_column="text" \
        --summary_column="event_triggers" \
        --per_device_train_batch_size="16" \
        --per_device_eval_batch_size="16" \
        --gradient_accumulation_steps="4" \
        --predict_with_generate \
        --save_strategy="steps" \
        --save_steps="500"
