#!/bin/bash
#FLUX: --job-name=gloopy-butter-9743
#FLUX: -c=40
#FLUX: --queue=nvidia
#FLUX: -t=19800
#FLUX: --urgency=16

module purge
source ~/.bashrc
conda activate llamaenv
python ../convert_llama_weights_to_hf.py \
    --input_dir ../weights_dir/ --model_size 65B --output_dir ../converted_checkpoints/65B
