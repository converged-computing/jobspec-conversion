#!/bin/bash
#FLUX: --job-name=roberta-flash-attention-train
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=21600
#FLUX: --urgency=16

module load miniconda/4.12.0
conda init bash
conda activate kiddothe2b
TOKENIZERS_PARALLELISM=false
MODEL_CLASS='roberta'
MODEL_PATH='roberta-base'
echo $SLURMD_NODENAME
echo $CUDA_VISIBLE_DEVICES
start_time=$(date +%s.%N)
python run_mlm.py \
    --model_class ${MODEL_CLASS} \
    --model_name_or_path ${MODEL_PATH} \
    --overwrite_output_dir \
    --do_train \
    --do_eval \
    --dataset_name c4 \
    --dataset_config_name en \
    --output_dir data/PLMs/${MODEL_PATH}-mlm-train \
    --logging_steps 1000 \
    --evaluation_strategy steps \
    --eval_steps 10000 \
    --max_steps 10000 \
    --per_device_train_batch_size 32 \
    --per_device_eval_batch_size 32 \
    --mlm_probability 0.15 \
    --max_seq_length 64 \
    --max_eval_samples 10000 \
    --save_strategy steps \
    --save_steps 10000 \
    --save_total_limit 5 \
    --streaming \
    --fp16 \
    --fp16_full_eval
end_time=$(date +%s.%N)
elapsed_time=$(echo "$end_time - $start_time" | bc)
echo "Elapsed time: $elapsed_time seconds"
