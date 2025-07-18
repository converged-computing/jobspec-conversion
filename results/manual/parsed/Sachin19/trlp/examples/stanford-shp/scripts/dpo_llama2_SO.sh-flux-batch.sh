#!/bin/bash
#FLUX: --job-name=joyous-cat-2707
#FLUX: -n=5
#FLUX: -t=0
#FLUX: --urgency=16

export HF_DATASETS_CACHE='/projects/tir6/general/sachink/huggingface'

set -x  # echo commands to stdout
set -e  # exit on error
export HF_DATASETS_CACHE="/projects/tir6/general/sachink/huggingface"
module load cuda-11.1.1 cudnn-11.1.1-v8.0.4.30
module load gcc-7.4
cd /projects/tir6/general/sachink/personalized-LM/2023/trl/examples/stanford-shp
torchrun --nnodes 1  --nproc_per_node 1 scripts/dpo_llama2.py\
    --model_name_or_path="/projects/tir6/general/sachink/personalized-LM/2023/models/0923/sft/llama_SO/final_checkpoint"\
    --output_dir="/projects/tir6/general/sachink/personalized-LM/2023/models/0923/dpo/llama_SO/"
