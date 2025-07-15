#!/bin/bash
#FLUX: --job-name=train-text-image
#FLUX: -c=4
#FLUX: -t=72000
#FLUX: --urgency=16

export HOME='<path to your new home>'
export MODEL_NAME='CompVis/stable-diffusion-v1-4'
export DATASET_NAME='./data/'
export OUTPUT_DIR='results/'

module load gcc/9.4.0 python/3.8.10 py-virtualenv/16.7.6
source <path to the virtualenv>/bin/activate  
cd $SLURM_SUBMIT_DIR
pwd
nvidia-smi
export HOME="<path to your new home>"
export MODEL_NAME="CompVis/stable-diffusion-v1-4"
export DATASET_NAME="./data/"
export OUTPUT_DIR="results/"
accelerate launch  train_text_to_image.py \
  --pretrained_model_name_or_path=$MODEL_NAME \
  --dataset_name=$DATASET_NAME \
  --use_ema \
  --resolution=512 \
  --train_batch_size=1 \
  --gradient_accumulation_steps=4 \
  --gradient_checkpointing \
  --max_train_steps=60000 \
  --learning_rate=1e-05 \
  --max_grad_norm=1 \
  --lr_scheduler="constant" --lr_warmup_steps=0 \
  --output_dir=$OUTPUT_DIR \
  --checkpoints_total_limit=3 \
  --resume_from_checkpoint="latest" \
