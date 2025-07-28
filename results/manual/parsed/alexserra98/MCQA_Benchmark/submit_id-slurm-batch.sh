#!/bin/bash
#FLUX: --job-name=test
#FLUX: -c=32
#FLUX: --queue=DGX
#FLUX: -t=21600
#FLUX: --urgency=16

export OMP_NUM_THREADS='32'
export PYTORCH_CUDA_ALLOC_CONF='expandable_segments:True'

source /u/area/ddoimo/anaconda3/bin/activate ./env_amd
export OMP_NUM_THREADS=32
export PYTORCH_CUDA_ALLOC_CONF="expandable_segments:True"
model_name=mistral-1-7b
path=mistral_v1
torchrun --rdzv-backend=c10d --rdzv-endpoint=localhost:0 \
       	--nnodes=1  --nproc-per-node=1 \
    diego/extraction/extract_repr.py \
    --checkpoint_dir  "/u/area/ddoimo/ddoimo/models/$path/models_hf/$model_name" \
    --use_slow_tokenizer \
    --preprocessing_num_workers 16 \
    --micro_batch_size 1 \
    --out_dir "./results" \
    --logging_steps 100 \
    --layer_interval 1 \
    --save_distances --save_repr \
    --remove_duplicates \
    --use_last_token \
    --max_seq_len 4090 \
    --split "dev+validation" \
    --num_few_shots 0 \
    --finetuned_path  "/u/area/ddoimo/ddoimo/finetuning_llm/open-instruct/results" \
    --finetuned_mode "dev_val_balanced_20samples" \
    --finetuned_epochs 4 \
    --step $step
    #--ckpt_epoch 4  
    #--split "test" \
    #--prompt_search
    #--random_order \
    #--skip_choices 
    #--wrong_answers  
    #--declarative 
    #--random_subject
    #--declarative
    #--sample_questions
    #--declarative \
    #--aux_few_shot 
    #--prompt_search \
    #--aux_few_shot  
    #--sample_questions
    # --finetuned_path  "/u/area/ddoimo/ddoimo/finetuning_llm/open-instruct/results" \
    # --finetuned_mode "test_balanced" \
    # --finetuned_epochs 4 \
    # --ckpt_epoch 3 
