#!/bin/bash
#SBATCH --job-name=dreamfusion
#SBATCH --output=slurm_logs/%x.%3a.%A.out
#SBATCH --error=slurm_logs/%x.%3a.%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=30G
#SBATCH --time=09:00:00
#SBATCH --array=0

MODEL_NAME="checkpoints/stable-diffusion-v1-5" # "path-to-pretrained-model" runwayml/stable-diffusion-v1-5
DATA_DIR="data/$2/image.jpg" # "path-to-dir-containing-your-image"
OUTPUT_DIR="outputs-textual-run/$2" # "path-to-desired-output-dir"
placeholder_token=$3 # _ironman_
init_token=$4 # ironman
echo "Placeholder Token $placeholder_token"
CUDA_VISIBLE_DEVICES=$1 accelerate launch textual-inversion/textual_inversion.py \
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
  --only_save_embeds \
  --validation_prompt "A high-resolution DSLR image of ${placeholder_token}" \
  --enable_xformers_memory_efficient_attention \
  --mixed_precision='fp16' \
  ${@:5}
