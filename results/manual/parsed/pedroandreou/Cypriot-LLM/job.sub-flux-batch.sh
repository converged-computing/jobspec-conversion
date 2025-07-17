#!/bin/bash
#FLUX: --job-name=loopy-plant-9233
#FLUX: --queue=gpu
#FLUX: -t=86400
#FLUX: --urgency=16

module load Python/3.9.6-GCCcore-11.2.0
if [ ! -d ".venv" ]; then
    pip install -e .
    python3 -m venv .venv
    source .venv/bin/activate
    pip install -r requirements.txt
else
    source .venv/bin/activate
fi
cd src
TOKENIZER_TYPE="WP"
BLOCK_SIZE=512
VOCAB_SIZE=30522
STRIP_ACCENTS="" # Set to true to activate
LOWERCASE="" # Set to True to activate
SLIDING_WINDOW_SIZE=8 # Alternatively, set it to 4
TOKENIZER_VERSION=1
ENCODINGS_VERSION=1
MLM_TYPE="static"
MLM_PROBABILITY=0.15
MODEL_TYPE="bert"
MASKED_ENCODINGS_VERSION=1
MAX_POS_EMBEDS=512 # Set 514 for RoBERTa
TRAINER_TYPE="pytorch"
TRAIN_BATCH_SIZE=32
EVAL_BATCH_SIZE=8
LEARNING_RATE=1e-4
NUM_TRAIN_EPOCHS=3
MODEL_VERSION=1
INPUT_UNMASKED_SEQUENCE="είσαι"
INPUT_MASKED_SEQUENCES=("Θώρει τη [MASK]." "Η τηλεόραση, το [MASK], τα φώτα." "Μεν τον [MASK] κόρη μου.")
if [ $SLURM_ARRAY_TASK_ID -eq 1 ]; then
    python main.py \
            --do_merge_docs
elif [ $SLURM_ARRAY_TASK_ID -eq 2 ]; then
    python main.py \
            --do_clean_data \
            --do_push_dataset_to_hub False
elif [ $SLURM_ARRAY_TASK_ID -eq 3 ]; then
    python main.py \
            --do_file_analysis
elif [ $SLURM_ARRAY_TASK_ID -eq 4 ]; then
    python main.py \
            --do_export_csv_to_txt_files \
            --do_load_dataset_from_hub False
elif [ $SLURM_ARRAY_TASK_ID -eq 5 ]; then
    python main.py \
            --do_train_tokenizer \
            --tokenizer_type $TOKENIZER_TYPE \
            --block_size $BLOCK_SIZE \
            --clean_text \
            --handle_chinese_chars False \
            --strip_accents $STRIP_ACCENTS \
            --lowercase $LOWERCASE \
            --vocab_size $VOCAB_SIZE \
            --limit_alphabet 1000 \
            --min_frequency 2 \
            --do_push_tokenizer_to_hub False
elif [ $SLURM_ARRAY_TASK_ID -eq 6 ]; then
    python main.py \
            --do_reformat_files \
            --sliding_window_size $SLIDING_WINDOW_SIZE
elif [ $SLURM_ARRAY_TASK_ID -eq 7 ]; then
    python main.py \
            --do_split_paths
elif [ $SLURM_ARRAY_TASK_ID -eq 8 ]; then
    python main.py \
            --do_tokenize_files \
            --tokenizer_type $TOKENIZER_TYPE \
            --tokenizer_version $TOKENIZER_VERSION \
            --block_size $BLOCK_SIZE
elif [ $SLURM_ARRAY_TASK_ID -eq 9 ]; then
    python main.py \
            --do_mask_files \
            --tokenizer_type $TOKENIZER_TYPE \
            --encodings_version $ENCODINGS_VERSION \
            --mlm_type $MLM_TYPE \
            --mlm_probability $MLM_PROBABILITY
elif [ $SLURM_ARRAY_TASK_ID -eq 10 ]; then
    python main.py \
            --do_train_model \
            --model_type $MODEL_TYPE \
            --tokenizer_type $TOKENIZER_TYPE \
            --masked_encodings_version $MASKED_ENCODINGS_VERSION \
            --seed 42 \
            --vocab_size $VOCAB_SIZE \
            --max_position_embeddings $MAX_POS_EMBEDS \
            --num_hidden_layers 6  \
            --hidden_size 768 \
            --num_attention_heads 12 \
            --type_vocab_size 1 \
            --trainer_type $TRAINER_TYPE \
            --do_apply_logit_norm False \
            --train_batch_size $TRAIN_BATCH_SIZE \
            --eval_batch_size $EVAL_BATCH_SIZE \
            --learning_rate $LEARNING_RATE \
            --num_train_epochs $NUM_TRAIN_EPOCHS
elif [ $SLURM_ARRAY_TASK_ID -eq 11 ]; then
    python main.py \
            --do_inference \
            --model_type $MODEL_TYPE \
            --model_version $MODEL_VERSION \
            --tokenizer_version $TOKENIZER_VERSION \
            --input_unmasked_sequence $INPUT_UNMASKED_SEQUENCE \
            --input_masked_sequences "${INPUT_MASKED_SEQUENCES[@]}"
fi
