#!/bin/bash
#FLUX: --job-name=dreamfusion
#FLUX: -t=32400
#FLUX: --urgency=16

module load gcc/7.5.0
echo "===> Anaconda env loaded"
source venv_magic123/bin/activate 
nvidia-smi
nvcc --version
hostname
NUM_GPU_AVAILABLE=`nvidia-smi --query-gpu=name --format=csv,noheader | wc -l`
echo "number of gpus:" $NUM_GPU_AVAILABLE
MODEL_NAME=$2 # "path-to-pretrained-model" runwayml/stable-diffusion-v1-5
DATA_DIR=$3 # "path-to-dir-containing-your-image"
OUTPUT_DIR=$4 # "path-to-desired-output-dir"
placeholder_token=$5 # _ironman_
init_token=$6 # ironman
CUDA_VISIBLE_DEVICES=$1 python textual-inversion/textual_inversion.py \
  --pretrained_model_name_or_path=$MODEL_NAME \
  --train_data_dir=$DATA_DIR \
  --learnable_property="object" \
  --placeholder_token=$placeholder_token \
  --initializer_token=$init_token \
  --resolution=512 \
  --train_batch_size=16 \
  --gradient_accumulation_steps=1 \
  --max_train_steps=3000 \
  --lr_scheduler="constant" \
  --lr_warmup_steps=0 \
  --output_dir=$OUTPUT_DIR \
  --use_augmentations \
  ${@:7}
CUDA_VISIBLE_DEVICES=$1 python guidance/sd_utils.py --text "A high-resolution DSLR image of <token>" --learned_embeds_path $OUTPUT_DIR  --workspace $OUTPUT_DIR 
