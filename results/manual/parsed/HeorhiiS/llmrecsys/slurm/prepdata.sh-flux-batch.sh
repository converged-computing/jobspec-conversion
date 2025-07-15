#!/bin/bash
#FLUX: --job-name=swampy-hippo-2834
#FLUX: -t=19800
#FLUX: --priority=16

module purge
source ~/.bashrc
conda activate llamaenv
python ../convert_llama_weights_to_hf.py \
    --input_dir ../weights_dir/ --model_size 65B --output_dir ../converted_checkpoints/65B
