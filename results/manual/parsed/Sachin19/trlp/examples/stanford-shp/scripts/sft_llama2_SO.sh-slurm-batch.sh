#!/bin/bash
#SBATCH --output=./slurm-outputs/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=50g
#SBATCH --exclude=tir-0-32,tir-0-36,tir-0-11,tir-1-32,tir-1-11,tir-1-23

export HF_DATASETS_CACHE='/projects/tir6/general/sachink/huggingface'

set -x  # echo commands to stdout
set -e  # exit on error
export HF_DATASETS_CACHE="/projects/tir6/general/sachink/huggingface"
module load cuda-11.1.1 cudnn-11.1.1-v8.0.4.30
module load gcc-7.4
cd /projects/tir6/general/sachink/personalized-LM/2023/trl/examples/stanford-shp
torchrun --nnodes 1  --nproc_per_node 1 scripts/sft_llama2.py\
    --data_source "SO"\
    --model_name="/projects/tir6/general/sachink/personalized-LM/2023/llama/hf_model-7B"\
    --streaming\
    --no_gradient_checkpointing\
    --learning_rate 1e-5\
    --max_steps 5000\
    --output_dir /projects/tir6/general/sachink/personalized-LM/2023/models/0923/sft/llama_SO
