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
torchrun --nnodes 1  --nproc_per_node 1 scripts/dpo_llama2.py\
    --model_name_or_path="/projects/tir6/general/sachink/personalized-LM/2023/models/0923/sft/llama_SO/final_checkpoint"\
    --output_dir="/projects/tir6/general/sachink/personalized-LM/2023/models/0923/dpo/llama_SO/"
