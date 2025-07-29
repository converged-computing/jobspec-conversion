#!/bin/bash
#SBATCH --output=./slurm-outputs/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=50g
#SBATCH --exclude=tir-0-32,tir-0-36,tir-0-11,tir-1-32,tir-0-32,tir-1-18,tir-1-13,tir-1-11,tir-0-3

export HF_DATASETS_CACHE='/projects/tir6/general/sachink/huggingface'

set -x  # echo commands to stdout
set -e  # exit on error
export HF_DATASETS_CACHE="/projects/tir6/general/sachink/huggingface"
module load cuda-11.1.1 cudnn-11.1.1-v8.0.4.30
module load gcc-7.4
source /projects/tir1/users/sachink/data/anaconda3/bin/activate 2022
cd /projects/tir6/general/sachink/personalized-LM/2023/trl/examples/stanford-shp
nvidia-smi
instrtype=$1
subset=$2
port=$3
torchrun --nnodes 1  --nproc_per_node 1 --rdzv_endpoint 0.0.0.0:$3 scripts/sft_llama2.py\
    --model_name="/projects/tir6/general/sachink/personalized-LM/2023/llama/hf_model-7B"\
    --streaming\
    --subset $subset\
    --no_gradient_checkpointing\
    --learning_rate 1e-5\
    --max_steps 5000\
    --data_dir /projects/tir6/general/sachink/personalized-LM/2023/chp\
    --instrtype $instrtype\
    --data_source chp\
    --output_dir /projects/tir6/general/sachink/personalized-LM/2023/models/1023-chp/sft/llama-7B_${instrtype}_${subset}
    # --data_dir stanfordnlp/shp\
