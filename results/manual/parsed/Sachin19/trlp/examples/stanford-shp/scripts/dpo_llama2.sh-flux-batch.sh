#!/bin/bash
#FLUX: --job-name=hanky-train-5767
#FLUX: -t=0
#FLUX: --urgency=16

export HF_DATASETS_CACHE='/projects/tir6/general/sachink/huggingface'

set -x  # echo commands to stdout
set -e  # exit on error
export HF_DATASETS_CACHE="/projects/tir6/general/sachink/huggingface"
module load cuda-11.1.1 cudnn-11.1.1-v8.0.4.30
module load gcc-7.4
source /projects/tir1/users/sachink/data/anaconda3/bin/activate 2022
cd /projects/tir6/general/sachink/personalized-LM/2023/trl/examples/stanford-shp
instrtype=$1
subset=$2
port=$3
WANDB__SERVICE_WAIT=300 torchrun --nnodes 1  --nproc_per_node 1 --rdzv_endpoint 0.0.0.0:$port scripts/dpo_llama2.py\
    --data_source chp\
    --model_name_or_path="/projects/tir6/general/sachink/personalized-LM/2023/models/1023-chp/sft/llama-7B_${instrtype}_${subset}/final_checkpoint"\
    --instrtype $instrtype\
    --subset $subset\
    --data_dir /projects/tir6/general/sachink/personalized-LM/2023/chp\
    --output_dir="/projects/tir6/general/sachink/personalized-LM/2023/models/1023-chp/dpo/llama-7B_${instrtype}_${subset}/"
