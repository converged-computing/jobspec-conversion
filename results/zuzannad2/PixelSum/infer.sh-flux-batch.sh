#!/bin/bash
# flux: --job-name=infer-pixelsum
# flux: -N 1                            # Number of nodes
# flux: -n 1                            # Total number of tasks
# flux: -c 48                           # Cores per task
# flux: --gpus-per-task=1               # GPUs per task
# flux: -q gpu                          # Target queue (assuming 'gpu' queue exists)
# flux: -t 3h                           # Walltime (3 hours)
# flux: --requires="mem>=70000M && accelerator_type==a100"
# The 'accelerator_type==a100' constraint assumes that the Flux instance
# has a resource property named 'accelerator_type' defined for GPUs.
# This might vary (e.g., 'gpu_model', 'gpu_product_name').
# Check your system's Flux resource properties for the correct key and value.
# For example, it could be 'gpu_product_name=="NVIDIA A100-SXM4-40GB"'.

nvidia-smi

export ENCODER="Team-PIXEL/pixel-base"
export DECODER="gpt2"
export DATASET="xsum"
export EXPERIMENT_DIR="experiments/inference/$DECODER/"`date +%Y-%m-%d_%H-%M-%S`

mkdir -p ${EXPERIMENT_DIR}

python3 -m scripts.training.run_inference \
                --model_path "" \
                --encoder_name ${ENCODER} \
                --decoder_name ${DECODER} \
                --processor_name ${ENCODER} \
                --tokenizer_name ${DECODER} \
                --fallback_fonts_dir "fonts" \
                --dataset_name ${DATASET} \
                --dataloader_num_workers 32 \
                --do_train false \
                --do_eval false \
                --do_predict true \
                --train_decoder false \
                --train_encoder false \
                --output_dir ${EXPERIMENT_DIR} \
                --log_predictions true \
                --eval_accumulation_steps 8 \
                --per_device_eval_batch_size 1 \
                --num_beams 1 \
                --max_predict_samples 1500 \
                --data_cache_dir 'cached_data'